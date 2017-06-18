class Page < ApplicationRecord

  has_many :sub_pages, dependent: :delete_all
  validates_presence_of :title
  validates :title, uniqueness: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

end
