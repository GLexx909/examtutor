require 'rails_helper'

RSpec.describe QuestionPassagesController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let!(:course)  { create :course }
  let!(:modul)  { create :modul, course: course }
  let!(:test)  { create :test, modul: modul }
  let!(:test_passage) { create :test_passage, test: test, user: user }
  let!(:question) { create :question, test: test }
  let!(:answer) { create :answer, question: question, body: '123' }

  describe 'POST #create' do
    before(:each) do
      login(user)
    end

    it_behaves_like 'To save a new object', let(:params) {{ question_id: question.id, answer: '123' }}, let(:object_class) { QuestionPassage }
  end
end
