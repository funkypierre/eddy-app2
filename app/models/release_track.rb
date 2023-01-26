class ReleaseTrack < ApplicationRecord
  belongs_to :release
  belongs_to :track

  validates :release, presence: true
  validates :track, presence: true
end
