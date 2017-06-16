class TeamMembership < ApplicationRecord

  belongs_to :user
  belongs_to :team

  validates_presence_of :user_id, :team_id
  validates_uniqueness_of :user_id, :scope => :team_id

end
