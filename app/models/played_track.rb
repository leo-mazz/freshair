class PlayedTrack < ApplicationRecord

  validates_presence_of :title, :artist, :podcast_id
  belongs_to :podcast

end
