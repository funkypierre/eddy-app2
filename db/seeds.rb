t1 = Time.now

SALE_COLUMNS_TO_IMPORT = %i[product_id product_type artist_id transaction_type net_share artist_share label_share].freeze

begin
  tracks = FastJsonparser.load('db/tracks.json')
rescue FastJsonparser::ParseError => e
  puts e.message
end

tracks.each_slice(1000) do |batch|
  batch.each do |track|
    name = track['Artist Name'.to_sym]
    upc = track[:UPC].to_s
    isrc = track[:ISRC].to_s
    next if [name, upc, isrc].any?(&:blank?)

    # avoiding to reload the artist for every entry
    artist = Artist.find_or_initialize_by(name:) unless artist.present? && artist.name == name
    artist.save!

    # model method using find_or_initialize_by
    release = Release.upc(upc) unless release.present? && release.upc == upc
    if release.new_record?
      release.title = track['Release title'.to_sym]
      release.year = track['Release year'.to_sym]
      release.artist_id = artist.id
    end
    release.save!

    new_track = Track.isrc(isrc) # find_or_initialize_by
    if new_track.new_record?
      new_track.title = track['Track Title'.to_sym]
      new_track.artist_id = artist.id
    end
    new_track.releases << release

    new_track.save!
  end
end

begin
  sales = FastJsonparser.load('db/sales-report.json')
rescue FastJsonparser::ParseError => e
  puts e.message
end

sales.each_slice(1000) do |batch|
  new_sales = []
  batch.each do |sale|
    trans_type = sale['Trans Type Description'.to_sym]
    product_code = sale['product code'.to_sym]
    net_share = sale['Label Share Net Receipts'.to_sym]
    next if [trans_type, product_code, net_share].any?(&:blank?)

    product = if Sale::RELEASE_TRANSACTION_TYPES.include?(trans_type)
                Release.upc(product_code) unless product.present? && product.upc == product_code
              elsif Sale::TRACK_TRANSACTION_TYPES.include?(trans_type)
                Track.isrc(product_code) unless product.present? && product.isrc == product_code
              end

    next if product.nil?

    artist_part = Sale::TRANSACTION_TYPES_RATES[trans_type.to_sym]
    artist_share = net_share * artist_part
    new_sales.push [
      product.id,
      product.class.name,
      product.artist_id,
      trans_type,
      net_share,
      artist_share,
      net_share - artist_share
    ]
  end

  Sale.import! SALE_COLUMNS_TO_IMPORT, new_sales
end

puts Time.now - t1
