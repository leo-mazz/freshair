class PlayedTrack < ApplicationRecord

  validates_presence_of :title, :artist, :podcast
  belongs_to :podcast

end
