require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let!(:user)  { create :user }
  let!(:user2)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let(:message)  { create :message, author: user, abonent: user2 }
  let(:message1)  { create :message, author: user, abonent: user2 }

  describe 'GET #abonents' do
    before do
      login(user)
      get :abonents
    end

    it 'render index view' do
      expect(response).to render_template :abonents
    end
  end

  describe 'GET #index' do
    let!(:messages)  { create_list :message, 3, author: user, abonent: user2 }

    before(:each) do
      login(user)
      get :index, params: { abonent_id: user2.id }
    end

    it_behaves_like 'To render index view'
    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'messages'}, let(:resource) { messages }
  end

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it_behaves_like 'To save a new object', let(:params) { { message: { body: 'MessageTExt' }, abonent_id: user2.id} }, let(:object_class) { Message }
    end

    context 'with invalid attributes' do
      it 'saves a new object in the database' do
        expect { post :create, params: { message: { body: '' }, abonent_id: user2.id}, format: :js }.to change(Message, :count).by(0)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create :user }
    let!(:other_user) { create :user }
    let!(:admin) { create :user, admin: true }
    let!(:message)  { create :message, author: user, abonent: other_user }

    context 'Author' do
      before(:each) do
        login(user)
      end

      it 'deletes the object' do
        expect { delete :destroy, params: { id: message.id, abonent_id: other_user.id }, format: :js }.to change(Message, :count).by(-1)
      end

      it_behaves_like 'DELETE to render status 200', let(:params) { { id: message.id, abonent_id: user2.id } }
    end

    context 'Not author' do
      before(:each) do
        login(other_user)
      end

      it 'can not deletes the object' do
        expect { delete :destroy, params: { id: message.id, abonent_id: user.id }, format: :js }.to change(Message, :count).by(0)
      end
    end

    context 'Admin' do
      before(:each) do
        login(admin)
      end

      it 'deletes the object' do
        expect { delete :destroy, params: { id: message.id, abonent_id: user.id }, format: :js }.to change(Message, :count).by(-1)
      end

      it_behaves_like 'DELETE to render status 200', let(:params) { { id: message.id, abonent_id: user2.id } }
    end
  end
end
