class Tag < ApplicationRecord

  after_initialize :default_to_non_post_type

  validates_presence_of :name
  validates :name, uniqueness: true
  validates :slug, uniqueness: true

  has_and_belongs_to_many :posts

  # For friendlier URLs, use the name of the tag instead of its id
  extend FriendlyId
  friendly_id :name, use: :slugged

  private

    def default_to_non_post_type
      self.is_post_type = false if self.is_post_type.nil?
    end
end
