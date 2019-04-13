require 'rails_helper'

RSpec.describe Test, type: :model do
  it { should validate_presence_of :title }

  it { should have_many(:users).through(:test_passages) }
  it { should have_many(:test_passages).dependent(:destroy) }
  it { should have_many(:questions).dependent(:destroy) }

  it { should belong_to(:modul) }

  let!(:user)       { create :user }
  let!(:course) { create :course }
  let!(:modul) { create :modul, course: course }
  let!(:test) { create :test, modul: modul }
  let!(:test_passage) { create :test_passage, test: test, user: user, points: 3 }
  let!(:question) { create :question, questionable: test }
  let!(:question2) { create :question, questionable: test }
  let!(:question_passage) { create :question_passage, question: question, user: user, points: 3 }
  let!(:answer) { create :answer, question: question, body: '123', points: 3 }
  let!(:answer2) { create :answer, question: question2, body: '123', points: 3 }

  describe 'test#all_points' do
    it 'return all points' do
      expect(test.all_points).to eq 6
    end
  end

  describe 'test#current_points(current_user)' do
    it 'return points' do
      expect(test.current_points(user)).to eq question_passage.points
    end
  end

  describe 'test#test_passage(current_user)' do
    it 'return test_passage' do
      expect(test.test_passage(user)).to eq test_passage
    end
  end
end
