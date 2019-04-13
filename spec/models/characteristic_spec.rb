require 'rails_helper'

RSpec.describe Characteristic, type: :model do
  it { should belong_to :user }
end
