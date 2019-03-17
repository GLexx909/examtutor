require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:user)  { create :user }
  let!(:post1)  { create :post, author: user }

  describe 'GET #index' do
    before(:each) do
      login(user)
      get :index
    end

    it_behaves_like 'To render index view'
    it_behaves_like 'To be a new',let(:object_class) { Post }, let(:object) { 'post' }
  end

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it_behaves_like 'To save a new object', let(:params) { post_params }, let(:object_class) { Post }
      it_behaves_like 'To render create.js view'
    end
  end

  describe 'GET #show' do
    before(:each) do
      login(user)
      get :show, params: { id: post1.id }
    end

    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'post'}, let(:resource) { post1 }
    it_behaves_like 'To render show view'
  end

  describe 'DELETE #destroy' do
    let!(:other_user) { create :user }
    let!(:admin) { create :user, admin: true }

    context 'Author' do
      before { login(user) }

      it_behaves_like 'To delete the object', let(:object) { post1 }, let(:object_class) { Post }
      it_behaves_like 'To render destroy.js view', let(:resource) { post1 }
    end

    context 'Not author' do
      before { login(other_user) }

      it_behaves_like 'To not delete the object', let(:object) { post1 }, let(:object_class) { Post }
      it_behaves_like 'DELETE to render status 403', let(:params) { post1 }
    end

    context 'Admin' do
      before { login(admin) }

      it_behaves_like 'To delete the object', let(:object) { post1 }, let(:object_class) { Post }
      it_behaves_like 'To render destroy.js view', let(:resource) { post1 }
    end
  end
end
