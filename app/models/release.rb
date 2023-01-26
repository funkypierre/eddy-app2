class Release < ApplicationRecord
  belongs_to :artist

  has_many :release_tracks
  has_many :tracks, through: :release_tracks

  has_many :sales, as: :product

  validates :title, presence: true
  validates :artist, presence: true
  validates :upc, presence: true
  validates :year, presence: true

  def self.upc(upc)
    find_or_initialize_by(upc:)
  end
end
