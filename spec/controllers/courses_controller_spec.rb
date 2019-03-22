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

  # describe 'GET #edit' do
  #   before(:each) do
  #     login(user)
  #     get :edit, params: { id: course }, format: :js
  #   end
  #
  #   # it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'course'}, let(:resource) { course }
  #   it 'assigns the requested resource to @resource' do
  #     expect(assigns(:course)).to eq course
  #   end
  # end

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
end
