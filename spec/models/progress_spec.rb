require 'rails_helper'

RSpec.describe Progress, type: :model do
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :date }
  it { should validate_presence_of :points }

  it { should belong_to :user }
end
