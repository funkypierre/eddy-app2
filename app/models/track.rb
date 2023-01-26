class Track < ApplicationRecord
  belongs_to :artist

  has_many :release_tracks
  has_many :releases, through: :release_tracks

  has_many :sales, as: :product

  validates :artist, presence: true
  validates :title, presence: true
  validates :isrc, presence: true

  def self.isrc(isrc)
    find_or_initialize_by(isrc:)
  end
end
