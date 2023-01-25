class Track < ApplicationRecord
  has_many :release_tracks
  has_many :releases, through: :release_tracks

  has_many :sales, as: :product

  def self.isrc(isrc)
    find_or_initialize_by(isrc:)
  end
end
