class ReleaseTrack < ApplicationRecord
  belongs_to :release
  belongs_to :track
end
