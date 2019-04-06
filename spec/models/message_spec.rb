require 'rails_helper'

RSpec.describe Message, type: :model do
  it { should belong_to(:abonent) }
  it { should belong_to(:author) }

  it { should validate_presence_of :body }
end
