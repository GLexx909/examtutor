require 'rails_helper'

RSpec.describe Modul, type: :model do
  it { should validate_presence_of :title }

  it { should have_many(:users).through(:modul_passages) }
  it { should have_many(:modul_passages).dependent(:destroy) }
  it { should have_many(:topics) }
  it { should have_many(:essays) }
  it { should belong_to(:course) }
end
