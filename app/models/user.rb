class User < ApplicationRecord

  validates_presence_of :first_name, :last_name
  rolify
  # has_and_belongs_to_many :shows, join_table: :hosts_shows
  has_many :show_memberships
  has_many :shows, through: :show_memberships

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :timeoutable, :lockable

  scope :to_approve, -> { where(approved: false) }
  scope :valid, -> { where("approved = ? AND confirmed_at IS NOT NULL", true ) }

  def name
    "#{first_name} #{last_name}"
  end

  def to_s
    name
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
