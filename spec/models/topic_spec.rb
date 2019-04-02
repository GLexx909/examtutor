require 'rails_helper'

RSpec.describe Topic, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should have_many(:users).through(:topic_passages) }
  it { should have_many(:topic_passages).dependent(:destroy) }
  it { should have_many(:questions).dependent(:destroy) }

  it { should belong_to(:modul) }

  let!(:user)       { create :user }
  let!(:course) { create :course }
  let!(:modul) { create :modul, course: course }
  let!(:topic) { create :topic, modul: modul }
  let!(:topic_passage) { create :topic_passage, topic: topic, user: user }

  describe 'topic#topic_passage(current_user)' do
    it 'return topic_passage' do
      expect(topic.topic_passage(user)).to eq topic_passage
    end
  end
end
