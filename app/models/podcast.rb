class Podcast < ApplicationRecord

  belongs_to :show
  validates_presence_of :show, :uri, :broadcast_date
  validates_with PodcastValidator

end
