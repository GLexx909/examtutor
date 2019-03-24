require 'rails_helper'

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should_not be_able_to :manage, :all }
    it { should_not be_able_to :tutor_index, Post }
    it { should_not be_able_to :read, Post }
    it { should be_able_to :guests_index, Post }

    it { should_not be_able_to :read, Course }
    it { should_not be_able_to :read, Modul }
    it { should_not be_able_to :read, Topic }
    it { should_not be_able_to :read, Essay }
  end

  describe 'for admin' do
    let(:user) { create :user, admin: true }

    it { should be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user)        { create :user }
    let(:user_other)  { create :user }
    let(:post)        { create :post, author: user }
    let(:post_other)  { create :post, author: user_other}
    let(:course)      { create :course }
    let(:modul)       { create :modul, course: course }
    let(:topic)       { create :topic, modul: modul }
    let(:essay)       { create :essay, modul: modul }
    let(:essay_passage){ create :essay_passage, essay: essay, user: user }

    it { should_not be_able_to :manage, :all }

    it { should be_able_to :read, Post }
    it { should be_able_to :tutor_index, Post }
    it { should be_able_to :own_index, Post }
    it { should be_able_to :guests_index, Post }

    it { should be_able_to :update, post }
    it { should_not be_able_to :update, post_other }

    it { should be_able_to :destroy, post }
    it { should_not be_able_to :destroy, post_other }

    it { should be_able_to :read, User }
    it { should be_able_to :update, User, user.id }

    it { should be_able_to :read, Course }
    it { should_not be_able_to :create, Course }
    it { should_not be_able_to :update, Course, course.id }
    it { should_not be_able_to :create, CoursePassage }

    it { should be_able_to :read, Modul }
    it { should_not be_able_to :create, Modul }
    it { should_not be_able_to :update, Modul, modul.id }
    it { should_not be_able_to :create, ModulPassage }

    it { should be_able_to :read, Topic }
    it { should_not be_able_to :create, Topic }
    it { should_not be_able_to :update, Topic, topic.id }

    it { should be_able_to :read, Essay }
    it { should_not be_able_to :create, Essay }
    it { should_not be_able_to :update, Essay, essay.id }
    it { should be_able_to :update, EssayPassage, essay_passage.id }
  end
end
