require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }
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

  describe 'PATCH #update_all' do
    let!(:notification1)  { create :notification, link: "/essays/#{essay.id}", abonent: user, status: false, author: user }
    let!(:notification2)  { create :notification, link: "/essays/#{essay.id}", abonent: user, status: false, author: user }

    before { login(user) }
    it 'change all notifications attribute' do
      patch :update_all, format: :js
      notification1.reload
      notification2.reload

      expect(notification1.status).to be_truthy
      expect(notification2.status).to be_truthy
    end
  end

  describe 'DELETE #destroy_all' do
    let!(:notification1)  { create :notification, link: "/topics/#{essay.id}", abonent: user, status: false, author: user }

    before(:each) do
      login(user)
      delete :destroy_all, format: :js
    end

    it 'deletes the object' do
      expect(Notification.where(abonent: user).count).to eq 0
    end

    it 'deletes the object' do
      expect(response).to render_template :destroy_all
    end
  end

  describe 'POST #send_for_all' do
    before { login(admin) }

    context 'Admin can' do
      it 'saves a new object in the database' do
        post :send_for_all, params: { title: ['New Notification'], format: :js }
        sleep 1
        expect(Notification.count).to eq 2
      end

      it 'render send_for_all.js view' do
        post :send_for_all, params: { title: ['New Notification'] }, format: :js
        expect(response).to render_template :send_for_all
      end
    end
  end
end
