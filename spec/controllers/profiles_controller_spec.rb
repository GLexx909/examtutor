require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let!(:user_other)  { create :user }

  describe 'GET #index' do
    before(:each) do
      login(user)
      get :index
    end

    it_behaves_like 'To render index view'
  end

  describe 'GET #show' do
    describe 'User can see the profile of other users' do
      before(:each) do
        login(user)
        get :show, params: { id: user_other }
      end

      it_behaves_like 'To render show view'
      it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'user'}, let(:resource) { user_other }
    end

    describe 'User can not see the profile of admin' do
      before(:each) do
        login(user)
        get :show, params: { id: admin }
      end

      it_behaves_like 'To redirect to path', let(:path) { root_path }
    end

    describe 'Admin can see the profile of admin' do
      before(:each) do
        login(admin)
        get :show, params: { id: admin }
      end

      it_behaves_like 'To render show view'
      it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'user'}, let(:resource) { admin }
    end
  end

  describe 'GET #edit' do
    before(:each) do
      login(user)
      get :edit, params: { id: user }
    end
    describe 'Authorised user edit own profile' do
      it_behaves_like 'To render edit view'
      it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'user'}, let(:resource) { user }
    end

    describe 'Authorised user can not edit other user profile' do
      before(:each) do
        login(user)
        get :edit, params: { id: user_other }
      end

      it_behaves_like 'To redirect to path', let(:path){ root_path }
    end

    describe 'Unauthorised user can not edit other user profile' do
      before(:each) do
        get :edit, params: { id: user_other }
      end

      it_behaves_like 'To redirect to path', let(:path){ root_path }
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before { login(user) }
      it_behaves_like 'To update the object', let(:params) { user_params }, let(:object) { user }
      it_behaves_like 'To render update view', let(:resource) { user }
    end

    context 'with invalid attributes' do
      let!(:user) { create :user, first_name: 'MyFirstName', last_name: 'MyLastName' }

      before do
        login(user)
        patch :update, params: user_params_invalid.merge({id: user.id }), format: :js
      end

      it 'does not change object' do
        user.reload

        expect(user.first_name).to eq 'MyFirstName'
        expect(user.last_name).to eq 'MyLastName'
      end
      it_behaves_like 'To render update view', let(:params) { user_params_invalid }, let(:object) { user }
    end

    context 'Admin can update other user profile' do
      let(:admin) { create :user, admin: true }

      before { login(admin) }
      it_behaves_like 'To update the object', let(:params) { user_params }, let(:object) { user }
      it_behaves_like 'To render update view', let(:resource) { user }
    end

    context 'Other user can' do
      let!(:user) { create :user, first_name: 'MyFirstName', last_name: 'MyLastName' }

      before do
        login(user_other)
        patch :update, params: user_params_new.merge({id: user.id }), format: :js
      end

      it 'not update other user profile' do
        expect(user.first_name).to eq 'MyFirstName'
      end

      it_behaves_like 'To redirect to path', let(:path){ root_path }
    end
  end

  describe 'DELETE #destroy' do
    let!(:other_user) { create :user }
    let!(:admin) { create :user, admin: true }

    context 'Admin' do
      before { login(admin) }

      it_behaves_like 'To delete the object', let(:object) { user }, let(:object_class) { User }
      it_behaves_like 'To render destroy.js view', let(:resource) { user }
    end

    context 'Not admin' do
      before { login(other_user) }

      it_behaves_like 'To not delete the object', let(:object) { user }, let(:object_class) { User }
      it_behaves_like 'DELETE to render status 403', let(:params) { user }
    end
  end
end
