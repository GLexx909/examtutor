require 'rails_helper'

RSpec.describe Admin::MainmenusController, type: :controller do
  let(:admin) { create :user, admin: true }

  describe 'GET #index' do
    before do
      login(admin)
      get :index
    end

    it_behaves_like 'To render index view'
  end
end
