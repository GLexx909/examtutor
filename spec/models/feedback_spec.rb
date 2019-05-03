require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it { should belong_to :user }

  it { should validate_presence_of :body }

  let!(:user) { create :user }
  let!(:feedback) { create :feedback, user: user, approved: true }
  let!(:feedback2) { create :feedback, user: user, approved: true }

  describe 'Feedback#approved' do
    it 'return all feedbacks where approved: true' do
      feedbacks_approved = [feedback, feedback2]
      expect(Feedback.approved).to eq feedbacks_approved
    end
  end
end
