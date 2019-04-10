require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:user)  { create :user }
  let!(:user_other)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let!(:post1)  { create :post, author: user }
  let!(:comment)  { create :comment, author: user, post: post1 }

  describe 'POST #create' do
    before { login(user) }
    context 'with valid attributes' do
      it_behaves_like 'To save a new object', let(:params) { comment_params(user, post1) }, let(:object_class) { Comment }
      it_behaves_like 'To render create.js view'
    end

    context 'with invalid attributes' do
      it_behaves_like 'To does not save a new object', let(:params) { comment_params_invalid(user, post1) }, let(:object_class) { Comment }
      it_behaves_like 'To render create.js view'
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before { login(user) }
      it_behaves_like 'To update the object', let(:params) { comment_params(user, post1) }, let(:object) { comment }
      it_behaves_like 'To change the object attributes title body', let(:params) { comment_params_new(user, post1) }, let(:object) { comment }
    end

    context 'with invalid attributes' do
      before { login(user) }
      let!(:comment) { create :comment, body: 'MyBody', author: user, post: post1 }

      it_behaves_like 'To not change the object attributes title body', let(:params) { comment_params_invalid(user, post1) }, let(:object) { comment }
      it_behaves_like 'To render update view', let(:params) { comment_params_invalid(user, post1) }, let(:object) { comment }
    end

    context 'Admin can update other user post' do
      before { login(admin) }
      it_behaves_like 'To update the object', let(:params) { comment_params(user, post1) }, let(:object) { comment }
      it_behaves_like 'To change the object attributes title body', let(:params) { comment_params_new(user, post1) }, let(:object) { comment }
    end
  end

  describe 'DELETE #destroy' do
    let!(:other_user) { create :user }
    let!(:admin) { create :user, admin: true }

    context 'Author' do
      before { login(user) }

      it_behaves_like 'To delete the object', let(:object) { comment }, let(:object_class) { Comment }
      it_behaves_like 'To render destroy.js view', let(:resource) { comment }
    end

    context 'Not author' do
      before { login(other_user) }

      it_behaves_like 'To not delete the object', let(:object) { comment }, let(:object_class) { Comment }
    end

    context 'Admin' do
      before { login(admin) }

      it_behaves_like 'To delete the object', let(:object) { comment }, let(:object_class) { Comment }
      it_behaves_like 'To render destroy.js view', let(:resource) { comment }
    end
  end
end
