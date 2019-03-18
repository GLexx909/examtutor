require 'rails_helper'

RSpec.describe OneTimePassword, type: :model do
  it { should validate_presence_of :pass_word }
end
