require 'rails_helper'

RSpec.describe TopicPassagesController, type: :controller do
  let!(:user)  { create :user }
  let!(:admin)  { create :user, admin: true }
  let!(:course)  { create :course }
  let!(:modul)  { create :modul, course: course }
  let!(:topic)  { create :topic, modul: modul }
  let!(:topic_passage)  { create :topic_passage, topic: topic, user: user }

  describe 'PATCH #update' do
    context 'with valid attributes' do
      before { login(user) }
      it 'change the object attributes' do
        patch :update, params: { id: topic_passage }, format: :js
        topic_passage.reload

        expect(topic_passage.status).to be_truthy
      end
    end
  end
end
