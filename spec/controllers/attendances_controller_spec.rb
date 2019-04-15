require 'rails_helper'

RSpec.describe AttendancesController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }

  describe 'GET #new' do
    before(:each) do
      login(admin)
      get :new
    end

    it_behaves_like 'To render new view'
  end

  describe 'POST #create' do
    context 'Admin create course' do
      before { login(admin) }
      context 'with valid attributes' do
        it_behaves_like 'To save a new object', let(:params) { { attendance: { user_id: user.id, description: 'Description' }, color: 'Red' } }, let(:object_class) { Attendance }
        it_behaves_like 'To render create.js view'
      end

      context 'with invalid attributes' do
        it_behaves_like 'To does not save a new object', let(:params) { { attendance: { user_id: nil, description: 'Description' }, color: 'Red' } }, let(:object_class) { Attendance }
        it_behaves_like 'To render create.js view'
      end
    end

    context 'Not admin create course' do
      before { login(user) }
      context 'with valid attributes' do
        it_behaves_like 'To does not save a new object', let(:params) { { attendance: { user_id: user.id, description: 'Description' }, color: 'Red' } }, let(:object_class) { Attendance }
      end
    end
  end
end
