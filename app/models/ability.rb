class Ability
  include CanCan::Ability

  attr_reader :user

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
    can :read, [Post, User, Course, Modul, Topic, Essay, Question, Notification, EssayPassage, TestPassage]
    can :tutor_index, Post
    can :own_index, Post
    can :create, [Post, TestPassage, QuestionPassage, Notification, EssayPassage]
    can :update, [Post, EssayPassage, TestPassage], author_id: user.id
    can :update, [EssayPassage, TopicPassage], user_id: user.id
    can :update, [Notification], abonent_id: user.id
    can :destroy, [Post], author_id: user.id

    can :update, [User], id: user.id
    can :update_status, [TestPassage], id: user.id
    can :start, Test
    can :abonents, Message
  end
end
