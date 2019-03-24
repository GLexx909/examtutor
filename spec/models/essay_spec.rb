require 'rails_helper'

RSpec.describe Essay, type: :model do
  it { should validate_presence_of :title }

  it { should have_many(:users).through(:essay_passages) }
  it { should have_many(:essay_passages).dependent(:destroy) }
  it { should belong_to(:modul) }
end
