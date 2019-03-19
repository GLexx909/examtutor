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
end
