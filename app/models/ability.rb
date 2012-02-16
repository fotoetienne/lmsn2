class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new(:role => 'guest') # guest user (not logged in)
    can :manage, User, :id => user.id
    cannot :switch, User
    can [:read, :search], [Dj, Song]
    can [:create, :read], SongRequest
    if user.admin?
      can :manage, :all
      can :access, :rails_admin
    elsif user.dj?
      can :manage, Dj, :user_id => user.id
      can :manage, Song, :dj_id => user.dj.id
      can :manage, SongRequest, :dj_id => user.dj.id
      can :read,   Singer
    elsif user.singer?
      can :manage, Singer, :user_id => user.id
      can :manage, SongRequest, :singer_id => user.singer.id
      can :read, [Song, Dj]
    end
    if Rails.env.development?
      can :switch, User
    end
    
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
