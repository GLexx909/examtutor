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
    can :guests_index, Post
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :read, [Post, User]
    can :tutor_index, Post
    can :own_index, Post
    can :create, [Post]
    can :update, [Post], author_id: @user.id
    can :destroy, [Post], author_id: @user.id

    can :edit, [User], id: @user.id
    can :update, [User], id: @user.id
  end
end