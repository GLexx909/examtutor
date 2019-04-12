require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body }
  it { should validate_presence_of :points }

  it { should belong_to(:question) }

  let!(:user)       { create :user }
  let!(:course) { create :course }
  let!(:modul) { create :modul, course: course }
  let!(:test) { create :test, modul: modul }
  let!(:test_passage) { create :test_passage, test: test, user: user, points: 3 }
  let!(:question_1) { create :question, questionable: test }
  let!(:answer_1) { create :answer, question: question_1, body: '123' }
  let!(:question_2) { create :question, questionable: test }
  let!(:answer_2) { create :answer, question: question_2, body: 'string' }


  describe 'answer.is_number?)' do
    it 'should return true' do
      expect(answer_1.is_number?).to be_truthy
    end

    it 'should return false' do
      expect(answer_2.is_number?).to be_falsey
    end
  end
end
