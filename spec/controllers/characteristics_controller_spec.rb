require 'rails_helper'

RSpec.describe CharacteristicsController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let!(:characteristic)  { create :characteristic, user: user }

  describe 'GET #index' do
    before(:each) do
      login(admin)
      get :index
    end

    it_behaves_like 'To render index view'
  end

  describe 'GET #show' do
    before(:each) do
      login(admin)
      get :show, params: { id: user }
    end

    it_behaves_like 'To render show view'
    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'user'}, let(:resource) { user }
  end

  describe 'GET #edit' do
    before(:each) do
      login(admin)
      get :edit, params: { id: user }, xhr: true
    end

    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'user'}, let(:resource) { user }
    it_behaves_like 'To render edit view'
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before { login(admin) }
      it_behaves_like 'To update the object', let(:params) { { characteristic: { description: 'New Description' }, id: user.id } }, let(:object) { user }
      it_behaves_like 'To change the object attributes title body', let(:params) { { characteristic: { description: 'New Description' } } }, let(:object) { user }
    end

    context 'User can not update essay' do
      before { login(user) }
      it_behaves_like 'To not change the object attributes title body', let(:params) { { characteristic: { description: 'New Description' } } }, let(:object) { user }
    end
  end
end
