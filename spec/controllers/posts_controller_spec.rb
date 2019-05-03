require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  it_behaves_like 'voted', let(:user){ create :user }, let(:user2){ create :user },
                  let(:votable) { create(:post, author: user) }

  let!(:user)  { create :user }
  let!(:user_other)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let!(:post1)  { create :post, author: user }

  describe 'GET #index' do
    before(:each) do
      login(user)
      get :index
    end

    it_behaves_like 'To render index view'
    it_behaves_like 'To be a new',let(:object_class) { Post }, let(:object) { 'post' }
  end

  describe 'GET #tutor_index' do
    before(:each) do
      login(user)
      get :tutor_index
    end

    it 'render index view' do
      expect(response).to render_template :tutor_index
    end
    it_behaves_like 'To be a new',let(:object_class) { Post }, let(:object) { 'post' }
  end

  describe 'GET #own_index' do
    before(:each) do
      login(user)
      get :own_index
    end

    it 'render index view' do
      expect(response).to render_template :own_index
    end
    it_behaves_like 'To be a new',let(:object_class) { Post }, let(:object) { 'post' }
  end

  describe 'GET #guests_index' do
    before(:each) do
      get :guests_index
    end

    it 'render index view' do
      expect(response).to render_template :guests_index
    end
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

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before { login(user) }
      it_behaves_like 'To update the object', let(:params) { post_params }, let(:object) { post1 }
      it_behaves_like 'To change the object attributes title body', let(:params) { post_params_new }, let(:object) { post1 }
    end

    context 'with invalid attributes' do
      before { login(user) }
      let!(:post1) { create :post, title: 'MyTitle', body: 'MyBody', author: user }

      it_behaves_like 'To not change the object attributes title body', let(:params) { post_params_invalid }, let(:object) { post1 }
      it_behaves_like 'To render update view', let(:params) { post_params_invalid }, let(:object) { post1 }
    end

    context 'Admin can update other user post' do
      before { login(admin) }
      it_behaves_like 'To update the object', let(:params) { post_params }, let(:object) { post1 }
      it_behaves_like 'To change the object attributes title body', let(:params) { post_params_new }, let(:object) { post1 }
    end

    context 'with invalid attributes' do
      before { login(user_other) }
      let!(:post1) { create :post, title: 'MyTitle', body: 'MyBody', author: user }

      it_behaves_like 'To not change the object attributes title body', let(:params) { post_params_new }, let(:object) { post1 }
    end
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
