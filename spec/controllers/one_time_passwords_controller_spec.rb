require 'rails_helper'

RSpec.describe Admin::OneTimePasswordsController, type: :controller do
  let!(:user) { create :user, admin: true }

  describe 'POST #new' do
    before do
      login(user)
      post :new, format: :js
    end

    it 'render new.js view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before do
      login(user)
    end

    context 'with valid attributes' do
      it_behaves_like 'To save a new object', let(:params) { one_time_password_params }, let(:object_class) { OneTimePassword }
      it_behaves_like 'To render create.js view'
    end
  end
end
