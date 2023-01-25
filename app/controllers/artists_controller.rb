class ArtistsController < ApplicationController
  CATALOG_LIMIT = 10.freeze

  def recap
    @artists = Artist.includes(:sales).all
    @artists_shares = artists_shares
  end

  def catalog
    @artists = Artist.includes(releases: :tracks).limit(CATALOG_LIMIT)
    filter_artists
  end

  private

  def filter_artists
    @artists = @artists.where(releases: { year: params[:year] }) if params[:year].present?
    @artists = @artists.where('lower(name) LIKE ?', "%#{params[:search]}%") if params[:search].present?
  end

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
