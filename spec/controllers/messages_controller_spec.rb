require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let!(:user)  { create :user }
  let!(:user2)  { create :user }
  let!(:message)  { create :message, author: user, abonent: user2 }

  describe 'GET #abonents' do
    before do
      login(user)
      get :abonents
    end

    it 'render index view' do
      expect(response).to render_template :abonents
    end
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
end
