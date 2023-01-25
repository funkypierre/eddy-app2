class Artist < ApplicationRecord
  has_many :releases
  has_many :tracks
  has_many :sales

  def total_share
    sales.load.sum(:artist_share)
  end
end
