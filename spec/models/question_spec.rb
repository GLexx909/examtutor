require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of :title }

  it { should have_one(:answer).dependent(:destroy) }
  it { should have_many(:question_passages).dependent(:destroy) }
  it { should have_many(:users).through(:question_passages) }

  it { should belong_to(:test) }
end
