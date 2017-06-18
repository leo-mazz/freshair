class Post < ApplicationRecord

  after_initialize :default_to_not_published

  validates_presence_of :title, :author
  validates :slug, uniqueness: true
  validates_with PostValidator

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_and_belongs_to_many :tags
  has_many :post_metadata
  belongs_to :show
  belongs_to :team

  accepts_nested_attributes_for :post_metadata, :allow_destroy => true

  # For friendlier URLs, use the title of the post instead of its id
  extend FriendlyId
  friendly_id :title, use: :slugged

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  def has_meta?(key)
    self.post_metadata.map(&:key).include? key
  end

  def get_meta(key)
    self.post_metadata.find_by_key(key).value
  end

  private

    def default_to_not_published
      self.is_published = false if self.is_published.nil?
    end

end
