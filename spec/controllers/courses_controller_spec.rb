require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let!(:course)  { create :course }

  describe 'GET #index' do
    before(:each) do
      login(user)
      get :index
    end

    it_behaves_like 'To render index view'
    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'courses'}, let(:resource) { Course.all }
  end

  describe 'GET #show' do
    before(:each) do
      login(user)
      get :show, params: { id: course }
    end

    it_behaves_like 'To render show view'
    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'course'}, let(:resource) { course }
  end

  describe 'POST #create' do
    context 'Admin create course' do
      before { login(admin) }
      context 'with valid attributes' do
        it_behaves_like 'To save a new object', let(:params) { course_params }, let(:object_class) { Course }
        it_behaves_like 'To render create.js view'
      end

      context 'with invalid attributes' do
        it_behaves_like 'To does not save a new object', let(:params) { course_params_invalid }, let(:object_class) { Course }
        it_behaves_like 'To render create.js view'
      end
    end

    context 'Not admin create course' do
      before { login(user) }
      context 'with valid attributes' do
        it_behaves_like 'To does not save a new object', let(:params) { course_params }, let(:object_class) { Course }
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before { login(admin) }
      it_behaves_like 'To update the object', let(:params) { course_params }, let(:object) { course }
      it_behaves_like 'To change the object attributes title body', let(:params) { course_params_new }, let(:object) { course }
    end

    context 'with invalid attributes' do
      before { login(admin) }
      let!(:course) { create :course, title: 'MyTitle' }

      it_behaves_like 'To not change the object attributes title body', let(:params) { course_params_invalid }, let(:object) { course }
    end

    context 'User can not update course' do
      before { login(user) }
      let!(:course) { create :course, title: 'MyTitle' }

      it_behaves_like 'To not change the object attributes title body', let(:params) { course_params}, let(:object) { course }
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create :user }
    let!(:admin) { create :user, admin: true }

    context 'Admin' do
      before { login(admin) }

      it_behaves_like 'To delete the object', let(:object) { course }, let(:object_class) { Course }
      it_behaves_like 'To render destroy.js view', let(:resource) { course }
    end

    context 'Not Admin' do
      before { login(user) }

      it_behaves_like 'To not delete the object', let(:object) { course }, let(:object_class) { Course }
    end
  end
end
