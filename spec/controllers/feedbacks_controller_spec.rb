require 'rails_helper'

RSpec.describe FeedbacksController, type: :controller do
  let!(:user)  { create :user }
  let!(:user2)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let(:feedback)  { create :feedback, user: user }

  describe 'GET #index' do
    before(:each) do
      login(user)
      get :index
    end

    it_behaves_like 'To render index view'
    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'feedbacks'}, let(:resource) { Feedback.order(created_at: :desc) }
  end

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      it_behaves_like 'To save a new object', let(:params) { { feedback: { body: 'feedbackTExt' } } }, let(:object_class) { Feedback }
    end

    context 'with invalid attributes' do
      it 'saves a new object in the database' do
        expect { post :create, params: { feedback: { body: '' } }, format: :js }.to change(Feedback, :count).by(0)
      end
    end
  end

  describe 'GET #edit' do
    before(:each) do
      login(user)
      get :edit, params: { id: feedback.id }, xhr: true
    end

    describe 'Authorised user edit feedback' do
      it_behaves_like 'To render edit view'
      it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'feedback'}, let(:resource) { feedback }
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before { login(user) }
      it_behaves_like 'To update the object', let(:params) { { feedback: { body: 'NewBody' }, id: feedback.id } }, let(:object) { feedback }
      it_behaves_like 'To render update view', let(:resource) { feedback }
    end

    context 'with invalid attributes' do
      let!(:feedback) { create :feedback, user: user, body: 'FeedbackBody' }

      before do
        login(user)
        patch :update, params: { feedback: { body: 'NewBody' }, id: feedback.id  }, format: :js
      end

      it 'does not change object' do
        feedback.reload
        expect(feedback.body).to eq 'NewBody'
      end
      it_behaves_like 'To render update view', let(:params) { { feedback: { body: 'NewBody' }, id: feedback.id  } }, let(:object) { feedback }
    end

    context 'Admin can update other user feedback' do
      before { login(admin) }
      it_behaves_like 'To update the object', let(:params) { { feedback: { body: 'NewBody' }, id: feedback.id  } }, let(:object) { feedback }
      it_behaves_like 'To render update view', let(:resource) { feedback }
    end

    context 'Other user can' do
      before do
        login(user2)
        patch :update, params: { feedback: { body: 'NewBody' }, id: feedback.id  }, format: :js
      end

      it 'not update other user profile' do
        expect(feedback.body).to_not eq 'NewBody'
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:feedback)  { create :feedback, user: user }

    context 'Author' do
      before(:each) do
        login(user)
      end

      it 'deletes the object' do
        expect { delete :destroy, params: { id: feedback.id }, format: :js }.to change(Feedback, :count).by(-1)
      end

      it_behaves_like 'To render destroy.js view', let(:resource) { feedback }
    end

    context 'Not author' do
      before(:each) do
        login(user2)
      end

      it 'can not deletes the object' do
        expect { delete :destroy, params: { id: feedback.id }, format: :js }.to change(Feedback, :count).by(0)
      end
    end

    context 'Admin' do
      before(:each) do
        login(admin)
      end

      it 'deletes the object' do
        expect { delete :destroy, params: { id: feedback.id }, format: :js }.to change(Feedback, :count).by(-1)
      end
    end
  end
end
