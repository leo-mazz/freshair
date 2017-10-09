class User < ApplicationRecord

  validates_presence_of :first_name, :last_name

  rolify
  # https://stackoverflow.com/questions/16782990/rails-how-to-populate-parent-object-id-using-nested-attributes-for-child-obje
  has_many :show_memberships, dependent: :delete_all, :inverse_of => :user
  has_many :shows, through: :show_memberships

  has_many :team_memberships, dependent: :delete_all, :inverse_of => :user
  has_many :teams, through: :team_memberships

  has_many :bookings, dependent: :delete_all

  has_many :podcasts, through: :shows
  has_many :show_posts, through: :shows, source: :posts
  has_many :posts, class_name: 'Post', foreign_key: 'author_id'

  accepts_nested_attributes_for :show_memberships, :allow_destroy => true
  accepts_nested_attributes_for :team_memberships, :allow_destroy => true

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :timeoutable, :lockable

  scope :to_approve, -> { where(approved: false) }
  scope :not_confirmed, -> { where(confirmed_at: nil) }
  scope :valid, -> { where("approved = ? AND confirmed_at IS NOT NULL", true ) }
  scope :by_first_name, -> { order(:first_name) }

  def name
    "#{first_name} #{last_name}"
  end

  def to_s
    name
  end

  # Include shows users can broadcast cause they're hub shows of their teams
  def all_shows
    hosted_shows = self.shows.to_a
    team_shows = self.teams.map(&:hub_show).compact.to_a
    return (hosted_shows + team_shows).uniq
  end

  def all_podcasts
    standard_podcasts = self.podcasts.to_a
    hub_podcasts = self.teams.map(&:hub_show).compact.map(&:podcasts).compact.flatten
    return standard_podcasts + hub_podcasts
  end

  def team_manager?
    self.team_memberships.where(is_manager: true).count > 0
  end

  # https://github.com/plataformatec/devise/wiki/How-To:-Require-admin-to-activate-account-before-sign_in
  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

end
