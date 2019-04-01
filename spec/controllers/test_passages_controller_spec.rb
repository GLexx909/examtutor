require 'rails_helper'

RSpec.describe TestPassagesController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let!(:course)  { create :course }
  let!(:modul)  { create :modul, course: course }
  let!(:test)  { create :test, modul: modul }
  let!(:test_passage)  { create :test_passage, test: test, user: user }

  describe 'GET #show' do
    before(:each) do
      login(user)
      get :show, params: { id: test_passage }
    end

    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'test_passage'}, let(:resource) { test_passage }
    it_behaves_like 'To render show view'
  end
end
