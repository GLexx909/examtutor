require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  let!(:user)  { create :user }
  let!(:course) { create :course }
  let!(:modul) { create :modul, course: course }
  let!(:essay) { create :essay, modul: modul }
  let(:notification)  { create :notification, link: "/essays/#{essay.id}" }

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
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before { login(user) }
      it_behaves_like 'To update the object', let(:params) { { id: notification, link: "/essays/#{essay.id}" } }, let(:object) { notification }

      it 'change the object attributes' do
        patch :update, params: { id: notification, link: "/essays/#{essay.id}" }, format: :js
        object.reload

        expect(notification.status).to be_truthy
      end
    end
  end
end
