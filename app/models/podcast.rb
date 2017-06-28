class Podcast < ApplicationRecord

  belongs_to :show
  # https://stackoverflow.com/questions/16782990/rails-how-to-populate-parent-object-id-using-nested-attributes-for-child-obje
  has_many :played_tracks, :inverse_of => :podcast

  validates_presence_of :show, :uri, :broadcast_date
  validates_with PodcastValidator

  accepts_nested_attributes_for :played_tracks, :allow_destroy => true

end
