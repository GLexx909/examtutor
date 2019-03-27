require 'rails_helper'

RSpec.describe Topic, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should have_many(:users).through(:topic_passages) }
  it { should have_many(:topic_passages).dependent(:destroy) }
  it { should belong_to(:modul) }
end
