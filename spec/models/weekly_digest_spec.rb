require 'rails_helper'

RSpec.describe WeeklyDigest, type: :model do
  it { should validate_presence_of :email }

  it { should belong_to(:user) }
end
