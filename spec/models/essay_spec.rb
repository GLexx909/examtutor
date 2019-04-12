require 'rails_helper'

RSpec.describe Essay, type: :model do
  it { should validate_presence_of :title }

  it { should have_many(:users).through(:essay_passages) }
  it { should have_many(:essay_passages).dependent(:destroy) }
  it { should belong_to(:modul) }

  let!(:user)       { create :user }
  let!(:course) { create :course }
  let!(:modul) { create :modul, course: course }
  let!(:essay) { create :essay, modul: modul }
  let!(:essay_passage) { create :essay_passage, essay: essay, user: user }

  describe 'essay#essay_passage(current_user)' do
    it 'return essay_passage' do
      expect(essay.essay_passage(user)).to eq essay_passage
    end
  end
end
