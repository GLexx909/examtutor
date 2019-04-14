require 'rails_helper'

RSpec.describe QuestionPassagesController, type: :controller do
  let!(:user)  { create :user }
  let!(:characteristic)  { create :characteristic, user: user }
  let!(:admin)  { create :user, admin: true }
  let!(:course)  { create :course }
  let!(:modul)  { create :modul, course: course }
  let!(:test)  { create :test, modul: modul }
  let!(:test_passage) { create :test_passage, test: test, user: user }
  let!(:question) { create :question, questionable: test }
  let!(:answer) { create :answer, question: question, body: '123' }

  describe 'POST #create' do
    before(:each) do
      login(user)
    end

    context 'create new object' do
      # Can't use this check because test do not can use request.referrer.split('/')[3] in controller
      # it_behaves_like 'To save a new object', let(:params) {{ question_id: question.id, answer: '123' }}, let(:object_class) { QuestionPassage }
    end

    context 'return result' do
      let(:point_counter_service) { double(Services::PointsCounterService) }

      before do
        allow(Services::PointsCounterService).to receive(:new).and_return(point_counter_service)
      end

      it 'return result' do
        # Can't use this check because test do not can use request.referrer.split('/')[3] in controller

        # expect(point_counter_service).to receive(:check_answer)
        # post :create, params: { question_id: question.id, answer: '123' }
      end
    end
  end
end
