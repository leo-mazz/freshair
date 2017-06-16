class Role < ApplicationRecord

  has_and_belongs_to_many :users, :join_table => :users_roles

  belongs_to :resource,
             :polymorphic => true,
             :optional => true

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify

  def self.public_roles
    {
      committee: 'Committee Member',
      programming: 'Head of Programming'
    }
  end

  def self.roles
    public_roles.merge({admin: 'System Administrator'})
  end

end
