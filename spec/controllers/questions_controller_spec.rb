require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let!(:course)  { create :course }
  let!(:modul)  { create :modul, course: course }
  let!(:test)  { create :test, modul: modul }
  let!(:question)  { create :question, test: test }


  describe 'GET #new' do
    before(:each) do
      login(admin)
      get :new, params: { test_id: test }, xhr: true
    end

    it_behaves_like 'To render new view'
    it_behaves_like 'To be a new', let(:object) {'question'}, let(:object_class) { Question }
  end

  describe 'POST #create' do
    context 'Admin create question' do
      before { login(admin) }
      context 'with valid attributes' do
        it_behaves_like 'To save a new object', let(:params) { question_params(test) }, let(:object_class) { Question }
        it_behaves_like 'To render create.js view'
      end

      context 'with invalid attributes' do
        it_behaves_like 'To does not save a new object', let(:params) { question_params_invalid(test) }, let(:object_class) { Question }
        it_behaves_like 'To render create.js view'
      end
    end

    context 'Not admin create question' do
      before { login(user) }
      context 'with valid attributes' do
        it_behaves_like 'To does not save a new object', let(:params) { question_params(test) }, let(:object_class) { Question }
      end
    end
  end

  describe 'GET #edit' do
    before(:each) do
      login(admin)
      get :edit, params: { id: question.id }, xhr: true
    end

    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'question'}, let(:resource) { question }
    it_behaves_like 'To render edit view'
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before { login(admin) }
      it_behaves_like 'To update the object', let(:params) { question_params(test) }, let(:object) { question }
      it_behaves_like 'To change the object attributes title body', let(:params) { question_params_new(test) }, let(:object) { question }
    end

    context 'with invalid attributes' do
      before { login(admin) }
      let!(:question) { create :question, title: 'MyTitle', test: test }

      it_behaves_like 'To not change the object attributes title body', let(:params) { question_params_invalid(test) }, let(:object) { question }
      it_behaves_like 'To render update view', let(:params) { question_params_invalid(test) }, let(:object) { question }
    end

    context 'User can not update question' do
      before { login(user) }
      let!(:question) { create :question, title: 'MyTitle', test: test }

      it_behaves_like 'To not change the object attributes title body', let(:params) { question_params(test) }, let(:object) { question }
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create :user }
    let!(:admin) { create :user, admin: true }

    context 'Admin' do
      before { login(admin) }

      it_behaves_like 'To delete the object', let(:object) { question }, let(:object_class) { Question }
    end

    context 'Not Admin' do
      before { login(user) }

      it_behaves_like 'To not delete the object', let(:object) { question }, let(:object_class) { Question }
    end
  end
end
