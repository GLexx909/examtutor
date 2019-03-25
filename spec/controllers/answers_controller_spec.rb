require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let!(:course)  { create :course }
  let!(:modul)  { create :modul, course: course }
  let!(:test)  { create :test, modul: modul }
  let!(:question)  { create :question, test: test }
  let!(:answer)  { create :answer, question: question }

  describe 'GET #edit' do
    before(:each) do
      login(admin)
      get :edit, params: { id: answer.id }, xhr: true
    end

    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'answer'}, let(:resource) { answer }
    it_behaves_like 'To render edit view'
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before { login(admin) }
      it_behaves_like 'To update the object', let(:params) { answer_params(test) }, let(:object) { answer }
      it_behaves_like 'To change the object attributes title body', let(:params) { answer_params_new(question) }, let(:object) { answer }
    end

    context 'with invalid attributes' do
      before { login(admin) }
      let!(:answer) { create :answer, body: 'MyBody', question: question }

      it_behaves_like 'To not change the object attributes title body', let(:params) { answer_params_invalid(question) }, let(:object) { answer }
      it_behaves_like 'To render update view', let(:params) { answer_params_invalid(question) }, let(:object) { answer }
    end

    context 'User can not update answer' do
      before { login(user) }
      let!(:answer) { create :answer, body: 'MyBody', question: question }

      it_behaves_like 'To not change the object attributes title body', let(:params) { answer_params(question) }, let(:object) { answer }
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create :user }
    let!(:admin) { create :user, admin: true }

    context 'Admin' do
      before { login(admin) }

      it_behaves_like 'To delete the object', let(:object) { answer }, let(:object_class) { Answer }
    end

    context 'Not Admin' do
      before { login(user) }

      it_behaves_like 'To not delete the object', let(:object) { answer }, let(:object_class) { Answer }
    end
  end
end
