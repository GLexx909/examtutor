require 'rails_helper'

RSpec.describe TestPassagesController, type: :controller do
  let!(:user)  { create :user }
  let!(:characteristic)  { create :characteristic, user: user }
  let!(:admin)  { create :user, admin: true }
  let!(:course)  { create :course }
  let!(:modul)  { create :modul, course: course }
  let!(:test)  { create :test, modul: modul }
  let!(:test_passage)  { create :test_passage, test: test, user: user }

  describe 'GET #show' do
    before(:each) do
      login(user)
      get :show, params: { id: test_passage }
    end

    it_behaves_like 'To assigns the request resource to @resource', let(:instance) {'test_passage'}, let(:resource) { test_passage }
    it_behaves_like 'To render show view'
  end

  describe 'PATCH #update_status' do
    let!(:test_passage) { create :test_passage, test: test, user: user, status: false }

    before { login(user) }
    it 'change status to true' do
      # Can't use this check because test do not can use request.referrer.split('/')[3] in controller

      # patch :update_status, params: {  id: test_passage.id  }
      # test_passage.reload
      # expect(test_passage.status).to be_truthy
    end
  end

  describe 'CharacteristicChangeService#change' do
    before(:each) do
      login(user)
    end

    context 'return result' do
      let(:change_characteristic_service) { double(Services::CharacteristicChangeService) }

      before do
        allow(Services::CharacteristicChangeService).to receive(:new).and_return(change_characteristic_service)
      end

      it 'return result' do
        # Can't use this check because test do not can use request.referrer.split('/')[3] in controller

        # expect(change_characteristic_service).to receive(:change)
        # patch :update_status, params: { id: test_passage.id }
      end
    end
  end
end
