require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let!(:user)  { create :user }
  let!(:user_other)  { create :user }

  describe 'GET #index' do
    before(:each) do
      login(user)
      get :index
    end

    it_behaves_like 'To render index view'
  end

  describe 'GET #show' do
    before(:each) do
      login(user)
      get :show, params: { id: user_other }
    end

    it_behaves_like 'To render show view'
    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'user'}, let(:resource) { user_other }
  end
end
