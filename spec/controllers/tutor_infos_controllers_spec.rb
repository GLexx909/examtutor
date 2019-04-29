require 'rails_helper'

RSpec.describe TutorInfosController, type: :controller do

  let!(:admin)  { create :user, admin: true }
  let!(:user)  { create :user }
  let!(:tutor_info)  { create :tutor_info }

  describe 'GET #index' do
    before(:each) do
      get :index
    end

    it_behaves_like 'To render index view'
  end

  describe 'PATCH #update' do
    context 'admin update tutor info' do
      before { login(admin) }
      it 'update the object in the database' do
        patch :update, params: { tutor_info: { description: 'NewDescription' }, id: tutor_info.id }, format: :js
        expect(assigns(:tutor_info)).to eq tutor_info
      end

      it 'change the object attributes' do
        patch :update, params: { tutor_info: { description: 'NewDescription' }, id: tutor_info.id }
        tutor_info.reload

        expect(tutor_info.description).to eq 'NewDescription'
      end
    end

    context 'user can not update tutor info' do
      before { login(user) }
      it 'change the object attributes' do
        patch :update, params: { tutor_info: { description: 'NewDescription' }, id: tutor_info.id }
        tutor_info.reload

        expect(tutor_info.description).to_not eq 'NewDescription'
      end

      it 'render status 403' do
        delete :update, params: { tutor_info: { description: 'NewDescription' }, id: tutor_info.id }, format: :js
        expect(response).to have_http_status 403
      end
    end
  end
end
