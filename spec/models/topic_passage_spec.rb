require 'rails_helper'

RSpec.describe TopicPassage, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:topic) }
end
