require 'rails_helper'

RSpec.describe TestPassage, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:test) }
end
