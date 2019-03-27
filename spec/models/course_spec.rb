require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should validate_presence_of :title }

  it { should have_many(:users).through(:course_passages) }
  it { should have_many(:course_passages).dependent(:destroy) }
  it { should have_many(:moduls).dependent(:destroy) }
end
