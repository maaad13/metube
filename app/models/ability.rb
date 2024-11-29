class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Video
    can :read, Comment

    if user.present?
      can :manage, Comment
      can :manage, Video
      can :manage, Like
    end

    if !user.present?
      can :read, video
    end
  end
end