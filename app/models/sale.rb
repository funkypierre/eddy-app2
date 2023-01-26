class Sale < ApplicationRecord
  TRANSACTION_TYPES_RATES = {
    "Download Albums": 0.3,
    "Subscription Audio Streams": 0.5,
    "Ad-Supported Audio Streams": 0.5,
    "Non-interactive Radio": 0.5,
    "Cloud Match Units": 0.5,
    "Mid-Tier Subscription Audio Streams": 0.5,
    "Physical Sales": 0.1,
    "Download Tracks": 0.3
  }.freeze

  RELEASE_TRANSACTION_TYPES = ['Download Albums', 'Physical Sales'].freeze
  TRACK_TRANSACTION_TYPES = [
    'Subscription Audio Streams',
    'Ad-Supported Audio Streams',
    'Non-interactive Radio',
    'Cloud Match Units',
    'Mid-Tier Subscription Audio Streams',
    'Download Tracks'
  ].freeze

  belongs_to :product, polymorphic: true
  belongs_to :artist

  validates :product, presence: true
  validates :artist, presence: true
  validates :transaction_type, presence: true
  validates :net_share, presence: true
  validates :label_share, presence: true
  validates :artist_share, presence: true
end
