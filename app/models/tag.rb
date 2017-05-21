class Tag < ApplicationRecord

  validates_presence_of :name
  validates :title, uniqueness: true
  validates :slug, uniqueness: true

  # For friendlier URLs, use the name of the tag instead of its id
  extend FriendlyId
  friendly_id :name, use: :slugged

end
