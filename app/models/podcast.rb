class Podcast < ApplicationRecord

  belongs_to :show
  has_many :played_tracks

  validates_presence_of :show, :uri, :broadcast_date
  validates_with PodcastValidator

  accepts_nested_attributes_for :played_tracks, :allow_destroy => true

end
