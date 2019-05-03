require 'rails_helper'

RSpec.describe ProgressesController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let!(:progress)  { create :progress, user: user, date: 'Апрель 2019' }

  describe 'GET #new' do
    before(:each) do
      login(admin)
      get :new
    end

    it_behaves_like 'To render new view'
  end

  describe 'POST #create' do
    context 'Admin create progress' do
      before { login(admin) }
      context 'with valid attributes' do
        it_behaves_like 'To save a new object', let(:params) { { progress: { user_id: user.id, points: '35', 'date(2i)' =>  '9', 'date(1i)' =>  '2019' } } }, let(:object_class) { Progress }
        it_behaves_like 'To render create.js view'
      end

      context 'with invalid attributes' do
        it_behaves_like 'To does not save a new object', let(:params) { { progress: { user_id: user.id, points: '', 'date(2i)' =>  '9', 'date(1i)' =>  '2019' } } }, let(:object_class) { Progress }
        it_behaves_like 'To render create.js view'
      end
    end

    context 'Not admin create progress' do
      before { login(user) }
      context 'with valid attributes' do
        it_behaves_like 'To does not save a new object', let(:params) { { progress: { user_id: user.id, points: '35', 'date(2i)' =>  '9', 'date(1i)' =>  '2019' } } }, let(:object_class) { Progress }
      end
    end
  end

  describe 'GET #edit' do
    before(:each) do
      login(admin)
      get :edit, params: { id: progress.id }, xhr: true
    end

    it_behaves_like 'To render edit view'
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before { login(admin) }
      it_behaves_like 'To update the object', let(:params) { { progress: { user_id: user.id, points: 35, 'date(2i)' =>  '9', 'date(1i)' =>  '2019' } } }, let(:object) { progress }

      it 'change the object attributes' do
        patch :update, params: { progress: { user_id: user.id, points: 35, 'date(2i)' =>  '9', 'date(1i)' =>  '2019' }, id: progress.id }, format: :js
        progress.reload

        expect(progress.points).to eq 35
      end

      it_behaves_like 'To render update view', let(:params) { { progress: { user_id: user.id, points: 35, 'date(2i)' =>  '9', 'date(1i)' =>  '2019' }, id: progress.id } }, let(:object) { progress }
    end

    context 'with invalid attributes' do
      before { login(admin) }

      it_behaves_like 'To not change the object attributes title body', let(:params) { { progress: { user_id: user.id, points: '', 'date(2i)' =>  '9', 'date(1i)' =>  '2019' }, id: progress.id } }, let(:object) { progress }
      it_behaves_like 'To render update view', let(:params) { { progress: { user_id: user.id, points: '', 'date(2i)' =>  '9', 'date(1i)' =>  '2019' }, id: progress.id } }, let(:object) { progress }
    end

    context 'User can not update attendance' do
      before { login(user) }
      it_behaves_like 'To not change the object attributes title body', let(:params) { { progress: { user_id: user.id, points: '35', 'date(2i)' =>  '9', 'date(1i)' =>  '2019' }, id: progress.id } }, let(:object) { progress }
    end
  end
end
