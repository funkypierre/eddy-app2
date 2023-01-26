class Artist < ApplicationRecord
  has_many :releases
  has_many :tracks
  has_many :sales

  validates :name, presence: true
end
