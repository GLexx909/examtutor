require 'rails_helper'

RSpec.describe Test, type: :model do
  it { should validate_presence_of :title }

  it { should have_many(:users).through(:test_passages) }
  it { should have_many(:test_passages).dependent(:destroy) }
  it { should belong_to(:modul) }
end
