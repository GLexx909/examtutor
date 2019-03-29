require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of :title }

  it { should have_one(:answer).dependent(:destroy) }
  it { should have_many(:question_passages).dependent(:destroy) }
  it { should have_many(:users).through(:question_passages) }

  it { should belong_to(:test) }

  let!(:user)       { create :user }
  let!(:course) { create :course }
  let!(:modul) { create :modul, course: course }
  let!(:test) { create :test, modul: modul }
  let!(:test_passage) { create :test_passage, test: test, user: user, points: 3 }
  let!(:question) { create :question, test: test }
  let!(:answer) { create :answer, question: question, body: '123' }

  describe 'question.test_passage(user)' do
    it 'should return test_passage of question' do
      expect(question.test_passage(user)).to eq test_passage
    end
  end

  describe 'question.points(user)' do
    it 'should return points of test_passage' do
      expect(question.points(user)).to eq 3
    end
  end
end
