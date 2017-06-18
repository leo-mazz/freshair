class SubPage < ApplicationRecord

  belongs_to :page
  validates_presence_of :title, :page
  validates :title, uniqueness: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

end
