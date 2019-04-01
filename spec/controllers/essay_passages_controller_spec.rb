require 'rails_helper'

RSpec.describe EssayPassagesController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let!(:course)  { create :course }
  let!(:modul)  { create :modul, course: course }
  let!(:essay)  { create :essay, modul: modul }
  let(:essay_passage) { create :essay_passage, essay: essay, user: user }


  describe 'GET #new' do
    before(:each) do
      login(admin)
      get :new, params: { essay_id: essay }, xhr: true
    end

    it_behaves_like 'To render new view'
    it_behaves_like 'To be a new', let(:object) {'essay_passage'}, let(:object_class) { EssayPassage }
  end

  describe 'GET #show' do
    before(:each) do
      login(user)
      get :show, params: { id: essay_passage }
    end

    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'essay_passage'}, let(:resource) { essay_passage }
    it_behaves_like 'To render show view'
  end

  describe 'POST #create' do
    context 'Admin create essay' do
      before { login(admin) }
      context 'with valid attributes' do
        it_behaves_like 'To save a new object', let(:params) { { essay_passage: {  body: '123' }, essay_id: essay.id }  }, let(:object_class) { EssayPassage }
        it 'redirect to path' do
          post :create, params: { essay_passage: {  body: '123' }, essay_id: essay.id }
          expect(response).to redirect_to essay_path(essay)
        end
      end

      context 'with invalid attributes' do
        it_behaves_like 'To does not save a new object', let(:params) { { essay_passage: {  body: '' }, essay_id: essay.id } }, let(:object_class) { EssayPassage }
        it 'redirect to path' do
          post :create, params: { essay_passage: {  body: '123' }, essay_id: essay.id }
          expect(response).to redirect_to essay_path(essay)
        end
      end
    end
  end

  describe 'PATCH #update' do
    let!(:essay_passage) { create :essay_passage, essay: essay, user: user }

    context 'with valid attributes' do
      before { login(user) }
      it 'update the object in the database' do
        patch :update, params: { essay_passage: { body: 'new_body' }, id: essay_passage.id }, format: :js
        expect(assigns(:essay_passage)).to eq essay_passage
      end
      it_behaves_like 'To change the object attributes title body', let(:params) { { essay_passage: { body: 'new_body' }, id: essay_passage.id } }, let(:object) { essay_passage }
    end

    context 'with invalid attributes' do
      before { login(user) }
      let!(:essay_passage) { create :essay_passage, body: 'MyBody', essay: essay, user: user }

      it_behaves_like 'To not change the object attributes title body', let(:params) { { essay_passage: { body: '' }, id: essay_passage.id } }, let(:object) { essay_passage }
      it_behaves_like 'To render update view', let(:params) { { essay_passage: { body: '' }, id: essay_passage.id } }, let(:object) { essay_passage }
    end
  end
end
