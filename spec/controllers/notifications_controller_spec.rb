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
      it 'saves a new object in the database' do
        expect { post :create, params: { notification: { abonent: user } }, format: :js }.to change(Notification, :count).by(1)
      end
      it 'render create.js view' do
        post :create, params: { notification: { abonent: user } }, format: :js
        expect(response).to render_template :create
      end
    end

    context 'additional action' do
      let(:notification_additional_action) { double(Services::NotificationAdditionalActions) }

      before do
        allow(Services::NotificationAdditionalActions).to receive(:new).and_return(notification_additional_action)
      end

      it 'do action' do
        expect(notification_additional_action).to receive(:action)
        post :create, params: { notification: { abonent: user } }, format: :js
      end
    end
  end
end
