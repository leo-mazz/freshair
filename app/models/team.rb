class Team < ApplicationRecord

  validates_presence_of :name

  belongs_to :hub_show, class_name: 'Show', foreign_key: 'hub_show_id'
  has_many :posts
  # https://stackoverflow.com/questions/16782990/rails-how-to-populate-parent-object-id-using-nested-attributes-for-child-obje
  has_many :team_memberships, :inverse_of => :team
  has_many :users, through: :team_memberships
  has_many :tags, through: :posts

  # For friendlier URLs, use the name of the team instead of its id
  extend FriendlyId
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  accepts_nested_attributes_for :team_memberships, allow_destroy: true

end
