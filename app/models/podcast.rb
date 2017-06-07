class Podcast < ApplicationRecord
  belongs_to :show
  validates_presence_of :show, :uri, :broadcast_date
  validates_with PodcastValidator

  def self.of_user(user)
    Show.of_user(user).map(&:podcasts).flatten
  end

end
