require 'rails_helper'

RSpec.describe EssaysController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let!(:course)  { create :course }
  let!(:modul)  { create :modul, course: course }
  let!(:essay)  { create :essay, modul: modul }


  describe 'GET #new' do
    before(:each) do
      login(admin)
      get :new, params: { modul_id: modul }, xhr: true
    end

    it_behaves_like 'To render new view'
    it_behaves_like 'To be a new', let(:object) {'essay'}, let(:object_class) { Essay }
  end

  describe 'POST #create' do
    context 'Admin create essay' do
      before { login(admin) }
      context 'with valid attributes' do
        it_behaves_like 'To save a new object', let(:params) { essay_params(modul) }, let(:object_class) { Essay }
        it_behaves_like 'To render create.js view'
      end

      context 'with invalid attributes' do
        it_behaves_like 'To does not save a new object', let(:params) { essay_params_invalid(modul) }, let(:object_class) { Essay }
        it_behaves_like 'To render create.js view'
      end
    end

    context 'Not admin create essay' do
      before { login(user) }
      context 'with valid attributes' do
        it_behaves_like 'To does not save a new object', let(:params) { essay_params(modul) }, let(:object_class) { Essay }
      end
    end
  end

  describe 'GET #edit' do
    before(:each) do
      login(admin)
      get :edit, params: { id: essay.id }, xhr: true
    end

    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'essay'}, let(:resource) { essay }
    it_behaves_like 'To render edit view'
  end

  describe 'GET #show' do
    before(:each) do
      login(user)
      get :show, params: { id: essay }
    end

    it_behaves_like 'To render show view'
    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'essay'}, let(:resource) { essay }
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before { login(admin) }
      it_behaves_like 'To update the object', let(:params) { essay_params(modul) }, let(:object) { essay }
      it_behaves_like 'To change the object attributes title body', let(:params) { essay_params_new(course) }, let(:object) { essay }
    end

    context 'with invalid attributes' do
      before { login(admin) }
      let!(:essay) { create :essay, title: 'MyTitle', modul: modul }

      it_behaves_like 'To not change the object attributes title body', let(:params) { essay_params_invalid(modul) }, let(:object) { essay }
      it_behaves_like 'To render update view', let(:params) { essay_params_invalid(modul) }, let(:object) { essay }
    end

    context 'User can not update essay' do
      before { login(user) }
      let!(:essay) { create :essay, title: 'MyTitle', modul: modul }

      it_behaves_like 'To not change the object attributes title body', let(:params) { essay_params(modul) }, let(:object) { essay }
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create :user }
    let!(:admin) { create :user, admin: true }

    context 'Admin' do
      before { login(admin) }

      it_behaves_like 'To delete the object', let(:object) { essay }, let(:object_class) { Essay }

      it 'redirect to path' do
        delete :destroy, params: { id: essay }
        expect(response).to redirect_to modul_path(modul)
      end
    end

    context 'Not Admin' do
      before { login(user) }

      it_behaves_like 'To not delete the object', let(:object) { essay }, let(:object_class) { Essay }
    end
  end
end
