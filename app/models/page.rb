class Page < ApplicationRecord

  has_many :sub_pages, dependent: :delete_all
  validates_presence_of :title
  validates :title, uniqueness: true

  extend FriendlyId
  friendly_id :title, use: :slugged
  
end
