require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:user)         { create :user }
  let!(:posts) { create_list :post, 3, user: user }

  describe 'GET #index' do
    before(:each) do
      login(user)
      get :index
    end

    it 'populates an array of all posts' do
      expect(Post.all).to match_array(posts)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it 'redirects to new_user_registration_path view' do
        post :create, params: { post: attributes_for(:post) }, format: :js
        expect(response).to render_template :create
      end
    end

    # context 'with invalid attributes' do
    #   it 'redirects to root_path view' do
    #     post :create, params: { preregistration_pass: 'invalid' }
    #     expect(response).to redirect_to root_path
    #   end
    # end
  end
end
