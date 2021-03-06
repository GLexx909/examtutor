require 'rails_helper'

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should_not be_able_to :manage, :all }
    it { should_not be_able_to :tutor_index, Post }
    it { should be_able_to :read, Post }
    it { should be_able_to :guests_index, Post }
    it { should be_able_to :read, Characteristic }
    it { should be_able_to :site_features, TutorInfo }
    it { should be_able_to :diplomas, TutorInfo }

    it { should_not be_able_to :read, Course }
    it { should_not be_able_to :read, Modul }
    it { should_not be_able_to :read, Topic }
    it { should_not be_able_to :read, Essay }
    it { should_not be_able_to :read, Test }
    it { should_not be_able_to :read, Question }
    it { should_not be_able_to :read, Answer }
    it { should_not be_able_to :destroy, user }
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
    let(:test)        { create :test, modul: modul }
    let(:question)    { create :question, questionable: test }
    let(:test_passage)    { create :test_passage, test: test, user: user }
    let(:topic_passage)    { create :topic_passage, topic: topic, user: user }
    let(:answer)      { create :answer, question: question }
    let(:notification) { create :notification, abonent: user }
    let(:message) { create :message, author: user, abonent: user_other, body: 'Message' }
    let(:message_other) { create :message, author: user_other, abonent: user, body: 'Message' }
    let(:comment) { create :comment, author: user, post: post }
    let(:feedback) { create :feedback, user: user }

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
    it { should be_able_to :update, TopicPassage, topic.id }

    it { should be_able_to :read, Essay }
    it { should_not be_able_to :create, Essay }
    it { should_not be_able_to :update, Essay, essay.id }
    it { should be_able_to :update, EssayPassage, essay_passage.id }

    it { should_not be_able_to :read, Test }
    it { should be_able_to :start, Test }
    it { should_not be_able_to :create, Test }
    it { should_not be_able_to :update, Test, test.id }
    it { should be_able_to :start, Test }

    it { should be_able_to :read, Question }
    it { should_not be_able_to :create, Question }
    it { should_not be_able_to :update, Question, question.id }

    it { should_not be_able_to :read, Answer }
    it { should_not be_able_to :create, Answer }
    it { should_not be_able_to :update, Answer, answer.id }

    it { should be_able_to :create, TestPassage }
    it { should be_able_to :read, TestPassage }
    it { should be_able_to :update_status, TestPassage, essay_passage.id }
    it { should be_able_to :create, QuestionPassage }

    it { should be_able_to :create, EssayPassage }
    it { should be_able_to :read, EssayPassage }
    it { should be_able_to :update, EssayPassage, user.id }

    it { should be_able_to :read, Notification }
    it { should be_able_to :create, Notification }
    it { should be_able_to :update, Notification, notification.id }
    it { should_not be_able_to :send_all_notification, Notification }

    it { should be_able_to :abonents, Message }
    it { should be_able_to :create, Message }
    it { should be_able_to :read, Message }
    it { should be_able_to :destroy, message }
    it { should_not be_able_to :destroy, message_other }

    it { should be_able_to :update_all, Notification }
    it { should be_able_to :destroy_all, Notification }

    it { should be_able_to :create, Comment }
    it { should be_able_to :update, comment }
    it { should be_able_to :destroy, comment }

    it { should be_able_to :manage, ActiveStorage::Attachment }

    it { should be_able_to :vote_up, post_other }
    it { should be_able_to :vote_down, post_other }

    it { should be_able_to :create, Feedback }
    it { should be_able_to :read, Feedback }
    it { should be_able_to :update, feedback }
    it { should be_able_to :destroy, feedback }
  end
end
