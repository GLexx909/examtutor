require 'rails_helper'

RSpec.describe CoursePassagesController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let!(:course) { create :course }
  let!(:modul) { create :modul, course: course }

  describe 'GET #new' do
    before(:each) do
      login(admin)
      get :new, xhr: true
    end

    it_behaves_like 'To render new view'
  end

  describe 'POST #create' do
    context 'Admin create course passage' do
      before { login(admin) }
      context 'with valid attributes' do
        it_behaves_like 'To save a new object', let(:params) { { course_passage: { user_id: user.id, course_id: course.id } } }, let(:object_class) { CoursePassage }
        it_behaves_like 'To render create.js view'
      end
    end

    context 'Not admin create course passage' do
      before { login(user) }
      context 'with valid attributes' do
        it_behaves_like 'To does not save a new object', let(:params) { { course_passage: { user_id: user.id, course_id: course.id } } }, let(:object_class) { CoursePassage }
      end
    end

    context 'To give access to user to еру new modul' do
      before(:each) do
        login(admin)
      end

      it 'it create modul_passage for course.users' do
        expect { post :create, params: { course_passage: { user_id: user.id, course_id: course.id } }, format: :js }.to change(ModulPassage, :count).by(1)
      end
    end
  end
end
