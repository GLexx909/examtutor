require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :password }

  it { should have_many(:posts).dependent(:destroy) }

  let!(:user)       { create :user }
  let!(:user_other) { create :user }
  let!(:post)       { create :post, author: user }


  describe 'User#author_of? check' do
    it 'is user the author of resource' do
      expect(user).to be_author_of(post)
    end

    it 'is user not author of resource' do
      expect(user_other).to_not be_author_of(post)
    end
  end
end
