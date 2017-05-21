class RolesService

  def self.public_roles
    {
      show_manager: 'Host or Producer',
      committee: 'Committee Member',
      publisher: 'Content Publisher',
      music_team: 'Music Team Member',
      programming: 'Head of Programming'
    }
  end

  def self.roles
    public_roles.merge({admin: 'System Administrator'})
  end

end
