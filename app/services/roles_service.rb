class RolesService

  def self.public_roles
    {
      committee: 'Committee Member',
      publisher: 'External Content Publisher',
      music_team: 'Music Team Member',
      programming: 'Head of Programming'
    }
  end

  def self.roles
    public_roles.merge({admin: 'System Administrator'})
  end

end
