class SubPage < ApplicationRecord

  belongs_to :page
  validates_presence_of :title, :page
  validates :title, uniqueness: true

  extend FriendlyId
  friendly_id :title, use: :slugged
  
end
