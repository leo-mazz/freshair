class RolesService

  def self.public_roles
    {
      committee: 'Committee Member',
      music_team: 'Music Team Member',
      art_team: 'Arts Team Member',
      news_team: 'News Team Member',
      sport_team: 'Sport Team Member',
      programming: 'Head of Programming'
    }
  end

  def self.roles
    public_roles.merge({admin: 'System Administrator'})
  end

end
