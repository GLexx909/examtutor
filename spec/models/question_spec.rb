require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of :title }

  it { should have_one(:answer).dependent(:destroy) }
  it { should have_many(:question_passages).dependent(:destroy) }
  it { should have_many(:users).through(:question_passages) }

  it { should belong_to(:questionable) }

  let!(:user)       { create :user }
  let!(:course) { create :course }
  let!(:modul) { create :modul, course: course }
  let!(:test) { create :test, modul: modul }
  let!(:topic) { create :topic, modul: modul }
  let!(:test_passage) { create :test_passage, test: test, user: user, points: 3 }
  let!(:topic_passage) { create :topic_passage, topic: topic, user: user }
  let!(:question) { create :question, questionable: test }
  let!(:question_topic) { create :question, questionable: topic }
  let!(:answer) { create :answer, question: question, body: '123' }

  describe 'question.test_passage(user)' do
    it 'should return test_passage of question' do
      expect(question.test_passage(user)).to eq test_passage
    end
  end

  describe 'question.topic_passage(user)' do
    it 'should return topic_passage of question' do
      expect(question_topic.topic_passage(user)).to eq topic_passage
    end
  end

  describe 'question.points(user)' do
    it 'should return points of test_passage' do
      expect(question.points(user)).to eq 3
    end
  end
end
