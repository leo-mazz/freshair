class AppDataService

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

  def self.locations
    {
      'Main Studio' => 1,
      'Recording Studio' => 2
    }
  end

  def self.teams
    {
      'music' => 1,
      'news' => 2,
      'sport' => 3,
      'arts' => 4
    }
  end

end
