require 'rails_helper'

RSpec.describe InitialsController, type: :controller do
  let!(:one_time_password) { create :one_time_password }

  describe 'GET #index' do
    before { get :index}
    it_behaves_like 'To render index view'
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'redirects to new_user_registration_path view' do
        post :create, params: { preregistration_pass: '123' }
        expect(response).to redirect_to new_user_registration_path
      end
    end

    context 'with invalid attributes' do
      it 'redirects to root_path view' do
        post :create, params: { preregistration_pass: 'invalid' }
        expect(response).to redirect_to root_path
      end
    end
  end
end
