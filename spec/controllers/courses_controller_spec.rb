require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }

  describe 'GET #index' do
    before(:each) do
      login(user)
      get :index
    end

    it_behaves_like 'To render index view'
    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'courses'}, let(:resource) { Course.all }
  end
end
