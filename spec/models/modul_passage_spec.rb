require 'rails_helper'

RSpec.describe ModulPassage, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:modul) }
end
