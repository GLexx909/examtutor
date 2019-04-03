require 'rails_helper'

RSpec.describe ModulsController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let!(:course)  { create :course }
  let!(:modul)  { create :modul, course: course }
  let!(:modul_passage) { create :modul_passage, modul: modul, user: user, status: true }

  describe 'GET #new' do
    before(:each) do
      login(admin)
      get :new, params: { course_id: course }, xhr: true
    end

    it_behaves_like 'To render new view'
    it_behaves_like 'To be a new', let(:object) {'modul'}, let(:object_class) { Modul }
  end

  describe 'POST #create' do
    context 'Admin create modul' do
      before { login(admin) }
      context 'with valid attributes' do
        it_behaves_like 'To save a new object', let(:params) { modul_params(course) }, let(:object_class) { Modul }
        it_behaves_like 'To render create.js view'
      end

      context 'with invalid attributes' do
        it_behaves_like 'To does not save a new object', let(:params) { modul_params_invalid(course) }, let(:object_class) { Modul }
        it_behaves_like 'To render create.js view'
      end
    end

    context 'Not admin create modul' do
      before { login(user) }
      context 'with valid attributes' do
        it_behaves_like 'To does not save a new object', let(:params) { modul_params(course) }, let(:object_class) { Modul }
      end
    end
  end

  describe 'GET #edit' do
    before(:each) do
      login(admin)
      get :edit, params: { id: modul.id }, xhr: true
    end

    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'modul'}, let(:resource) { modul }
    it_behaves_like 'To render edit view'
  end

  describe 'GET #show' do
    before(:each) do
      login(user)
      get :show, params: { id: modul }
    end

    it_behaves_like 'To render show view'
    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'modul'}, let(:resource) { modul }
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before { login(admin) }
      it_behaves_like 'To update the object', let(:params) { modul_params(course) }, let(:object) { modul }
      it_behaves_like 'To change the object attributes title body', let(:params) { modul_params_new(course) }, let(:object) { modul }
    end

    context 'with invalid attributes' do
      before { login(admin) }
      let!(:modul) { create :modul, title: 'MyTitle', course: course }

      it_behaves_like 'To not change the object attributes title body', let(:params) { modul_params_invalid(course) }, let(:object) { modul }
      it_behaves_like 'To render update view', let(:params) { modul_params_invalid(course) }, let(:object) { modul }
    end

    context 'User can not update modul' do
      before { login(user) }
      let!(:modul) { create :modul, title: 'MyTitle', course: course }

      it_behaves_like 'To not change the object attributes title body', let(:params) {modul_params(course) }, let(:object) { modul }
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create :user }
    let!(:admin) { create :user, admin: true }

    context 'Admin' do
      before { login(admin) }

      it_behaves_like 'To delete the object', let(:object) { modul }, let(:object_class) { Modul }
      it_behaves_like 'To render destroy.js view', let(:resource) { modul }
    end

    context 'Not Admin' do
      before { login(user) }

      it_behaves_like 'To not delete the object', let(:object) { modul }, let(:object_class) { Modul }
    end
  end
end
