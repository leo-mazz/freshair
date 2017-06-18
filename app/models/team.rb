class Team < ApplicationRecord

  validates_presence_of :name

  has_many :posts

  has_many :team_memberships
  has_many :users, through: :team_memberships

  # For friendlier URLs, use the name of the team instead of its id
  extend FriendlyId
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  accepts_nested_attributes_for :team_memberships, allow_destroy: true

end
