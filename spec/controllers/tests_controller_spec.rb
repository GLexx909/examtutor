require 'rails_helper'

RSpec.describe TestsController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let!(:course)  { create :course }
  let!(:modul)  { create :modul, course: course }
  let!(:test)  { create :test, modul: modul }


  describe 'GET #new' do
    before(:each) do
      login(admin)
      get :new, params: { modul_id: modul }, xhr: true
    end

    it_behaves_like 'To render new view'
    it_behaves_like 'To be a new', let(:object) {'test'}, let(:object_class) { Test }
  end

  describe 'POST #create' do
    context 'Admin create test' do
      before { login(admin) }
      context 'with valid attributes' do
        it_behaves_like 'To save a new object', let(:params) { test_params(modul) }, let(:object_class) { Test }
        it_behaves_like 'To render create.js view'
      end

      context 'with invalid attributes' do
        it_behaves_like 'To does not save a new object', let(:params) { test_params_invalid(modul) }, let(:object_class) { Test }
        it_behaves_like 'To render create.js view'
      end
    end

    context 'Not admin create test' do
      before { login(user) }
      context 'with valid attributes' do
        it_behaves_like 'To does not save a new object', let(:params) { test_params(modul) }, let(:object_class) { Test }
      end
    end
  end

  describe 'GET #edit' do
    before(:each) do
      login(admin)
      get :edit, params: { id: test.id }, xhr: true
    end

    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'test'}, let(:resource) { test }
    it_behaves_like 'To render edit view'
  end

  describe 'GET #show' do
    before(:each) do
      login(admin)
      get :show, params: { id: test }
    end

    it_behaves_like 'To render show view'
    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'test'}, let(:resource) { test }
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before { login(admin) }
      it_behaves_like 'To update the object', let(:params) { test_params(modul) }, let(:object) { test }
      it_behaves_like 'To change the object attributes title body', let(:params) { test_params_new(course) }, let(:object) { test }
    end

    context 'with invalid attributes' do
      before { login(admin) }
      let!(:test) { create :test, title: 'MyTitle', modul: modul }

      it_behaves_like 'To not change the object attributes title body', let(:params) { test_params_invalid(modul) }, let(:object) { test }
      it_behaves_like 'To render update view', let(:params) { test_params_invalid(modul) }, let(:object) { test }
    end

    context 'User can not update test' do
      before { login(user) }
      let!(:test) { create :test, title: 'MyTitle', modul: modul }

      it_behaves_like 'To not change the object attributes title body', let(:params) { test_params(modul) }, let(:object) { test }
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create :user }
    let!(:admin) { create :user, admin: true }

    context 'Admin' do
      before { login(admin) }

      it_behaves_like 'To delete the object', let(:object) { test }, let(:object_class) { Test }

      it 'redirect to path' do
        delete :destroy, params: { id: test }
        expect(response).to redirect_to modul_path(modul)
      end
    end

    context 'Not Admin' do
      before { login(user) }

      it_behaves_like 'To not delete the object', let(:object) { test }, let(:object_class) { Test }
    end
  end

  describe 'GET #start' do
    before(:each) do
      login(admin)
      get :start, params: { id: test.id }, xhr: true
    end

    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'test'}, let(:resource) { test }
    it 'render show view' do
      expect(response).to render_template :start
    end
  end
end
