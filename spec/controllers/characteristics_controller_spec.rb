require 'rails_helper'

RSpec.describe CharacteristicsController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }

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
end
