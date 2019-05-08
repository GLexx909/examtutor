require 'rails_helper'

RSpec.describe AttendancesController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let!(:attendance)  { create :attendance, user: user, date: DateTime.now }

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
        it_behaves_like 'To save a new object', let(:params) { { attendance: { user_id: user.id, description: 'Description', date: DateTime.now }, color: 'Red' } }, let(:object_class) { Attendance }
        it_behaves_like 'To render create.js view'
      end

      context 'with invalid attributes' do
        it_behaves_like 'To does not save a new object', let(:params) { { attendance: { user_id: nil, description: 'Description', date: DateTime.now }, color: 'Red' } }, let(:object_class) { Attendance }
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

  describe 'GET #edit' do
    before(:each) do
      login(admin)
      get :edit, params: { id: attendance.id }, xhr: true
    end

    it_behaves_like 'To render edit view'
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before { login(admin) }
      it_behaves_like 'To update the object', let(:params) { { attendance: { user_id: user.id, description: 'Description New' }, color: 'Red' } }, let(:object) { attendance }

      it 'change the object attributes' do
        patch :update, params: { attendance: { user_id: user.id, description: 'Description New' }, color: 'Red', id: attendance.id }, format: :js
        attendance.reload

        expect(attendance.description).to eq 'Description New'
      end

      it_behaves_like 'To render update view', let(:params) { { attendance: { user_id: user.id, description: 'Description New' }, color: 'Red' } }, let(:object) { attendance }
    end

    context 'with invalid attributes' do
      before { login(admin) }

      it_behaves_like 'To not change the object attributes title body', let(:params) { { attendance: { user_id: user.id, description: '' }, color: 'Red' } }, let(:object) { attendance }
      it_behaves_like 'To render update view', let(:params) { { attendance: { user_id: user.id, description: '' }, color: 'Red' } }, let(:object) { attendance }
    end

    context 'User can not update attendance' do
      before { login(user) }
      it_behaves_like 'To not change the object attributes title body', let(:params) { { attendance: { user_id: user.id, description: 'Description New' }, color: 'Red' } }, let(:object) { attendance }
    end
  end

  describe 'DELETE #destroy' do
    context 'Admin' do
      before(:each) do
        login(admin)
      end

      it 'deletes the object' do
        expect { delete :destroy, params: { id: attendance.id }, format: :js }.to change(Attendance, :count).by(-1)
      end

      it_behaves_like 'To render destroy.js view', let(:resource) { attendance.id  }, format: :js
    end
  end
end




