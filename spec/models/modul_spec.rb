require 'rails_helper'

RSpec.describe Modul, type: :model do
  it { should validate_presence_of :title }

  it { should have_many(:users).through(:modul_passages) }
  it { should have_many(:modul_passages).dependent(:destroy) }
  it { should have_many(:topics) }
  it { should have_many(:essays) }
  it { should have_many(:tests) }

  it { should belong_to(:course) }

  let!(:user)       { create :user }
  let!(:course) { create :course }
  let!(:modul) { create :modul, course: course }
  let!(:modul_passage) { create :modul_passage, modul: modul, user: user }
  let!(:topic) { create :topic, modul: modul }
  let!(:topic_passage) { create :topic_passage, topic: topic, user: user, status: true }
  let!(:essay) { create :essay, modul: modul }
  let!(:essay_passage) { create :essay_passage, essay: essay, user: user, status: true }
  let!(:test) { create :test, modul: modul }
  let!(:test_passage) { create :test_passage, test: test, user: user, points: 3, status: true }
  let!(:question) { create :question, questionable: test }
  let!(:question_passage) { create :question_passage, question: question, user: user, points: 3 }
  let!(:answer) { create :answer, question: question, body: '123' }

  describe 'modul#over?(current_user)' do
    it 'should return true' do
      expect(modul.over?(user)).to be_truthy
    end
  end

  describe 'modul#modul_passage(current_user)' do
    it 'return modul_passage' do
      expect(modul.modul_passage(user)).to eq modul_passage
    end
  end
end
