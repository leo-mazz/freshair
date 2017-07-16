class Tag < ApplicationRecord

  after_initialize :set_defaults

  mount_uploader :pic, TagPicUploader

  validates_presence_of :name
  validates :name, uniqueness: true
  validates :slug, uniqueness: true
  validates_with TagValidator

  has_and_belongs_to_many :posts

  # For friendlier URLs, use the name of the tag instead of its id
  extend FriendlyId
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  def self.post_types
    Tag.where(is_post_type: true)
  end

  private

    def set_defaults
      self.is_highlighted = false if self.is_highlighted.nil?
      self.is_post_type = false if self.is_post_type.nil?
    end
end
