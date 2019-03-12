class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    # can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :read, [Post]
    can :create, [Post]
    can :update, [Post], user_id: @user.id
    can :destroy, [Post], user_id: @user.id

    # can :vote_up, [Question, Answer] do |votable|
    #   !user.author_of?(votable)
    # end
    #
    # can :vote_down, [Question, Answer] do|votable|
    #   !user.author_of?(votable)
    # end
    #
    # can :manage, ActiveStorage::Attachment do |attachment|
    #   user.author_of?(attachment.record)
    # end
    #
    # can :mark_best, Answer, question: { author_id: user.id }
    # can :destroy, Link, linkable: { author_id: user.id }
    # can :me, User, id: user.id
  end
end
