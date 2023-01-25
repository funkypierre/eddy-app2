class ArtistsController < ApplicationController
  def index
    @artists = Artist.includes(:sales).all
    @artists_shares = artists_shares
    # @artists = serialized_artists
    # puts "tata", artists_shares
  end

  private

  # def serialized_artists
  #   @artists.map do |artist|
  #     { name: artist.name, shares: artists_shares[artist.id] }
  #   end
  # end

  def artists_shares
    @sales_by_artist ||= @artists.group(:artist_id)
    {
      net_shares: @sales_by_artist.sum(:net_share),
      label_shares: @sales_by_artist.sum(:label_share),
      artist_shares: @sales_by_artist.sum(:artist_share),
      product_shares: @sales_by_artist.group('sales.product_type').sum(:net_share)
    }
  end
end
