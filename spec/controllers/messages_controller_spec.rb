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
end
