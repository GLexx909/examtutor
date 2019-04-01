require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  let!(:user)  { create :user }

  describe 'GET #index' do
    before(:each) do
      login(user)
      get :index
    end

    it_behaves_like 'To render index view'
  end

  describe 'POST #create' do
    before { login(user) }
    context 'with valid attributes' do
      it_behaves_like 'To save a new object', let(:params) { { notification: attributes_for(:notification) } }, let(:object_class) { Notification }
      it_behaves_like 'To render create.js view'
    end

    context 'additional action' do
      let(:notification_additional_action) { double(Services::NotificationAdditionalActions) }

      before do
        allow(Services::NotificationAdditionalActions).to receive(:new).and_return(notification_additional_action)
      end

      it 'do action' do
        expect(notification_additional_action).to receive(:action)
        post :create, params: { notification: attributes_for(:notification) }, format: :js
      end
    end
  end
end
