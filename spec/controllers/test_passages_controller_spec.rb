require 'rails_helper'

RSpec.describe TestPassagesController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let!(:course)  { create :course }
  let!(:modul)  { create :modul, course: course }
  let!(:test)  { create :test, modul: modul }
  let!(:test_passage)  { create :test_passage, test: test, user: user }

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before { login(user) }
      it 'change the object attributes' do
        put :update, params: {id: test_passage.id }
        test_passage.reload

        expect(test_passage.status).to be_truthy
      end
    end
  end
end
