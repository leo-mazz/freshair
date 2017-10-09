# Define abilities for the passed in user here
class Ability

  include CanCan::Ability

  def initialize(user)

    # System Administrators
    if user.has_role? :admin
      can :manage, :all
      return
    end

    # Everyone
    can :read, ActiveAdmin::Page, name: "Dashboard"
    can :read, Booking
    can :create, Booking
    can :manage, Booking, :user_id => user.id
    can :create, Post
    can :manage, Post, :author_id => user.id
    can :create, Tag

    # TODO: think of all the fields with collections excluded for pseudoadmin people
    # Head of programming
    if user.has_role? :programming
      can :manage, Show
      can :manage, Schedule
      can :manage, Booking
    end

    # Heads of team
    # user can manage a post that is assigned to a team the user manages
    can :manage, Post, team: {team_memberships: {user_id: user.id, is_manager: true}}
    # user can read and update a team it manages
    can [:read, :update], Team, team_memberships: {user_id: user.id, is_manager: true}
    # user can read and update a show assigned to a team the user manages
    can [:read, :update], Show, team: {team_memberships: {user_id: user.id, is_manager: true}}

    # Committee members
    if user.has_role? :committee
      can :manage, Tag
      can [:read, :update], Page
      can :manage, SubPage
      can :manage, Event
    end

    # Hosts
    can [:read, :update], Show, :id => user.shows.map(&:id)
    can :create, Podcast
    can :manage, Podcast, :id => user.all_podcasts.map(&:id)
    can :manage, Post, :show_id => user.shows.map(&:id)

  end

end
