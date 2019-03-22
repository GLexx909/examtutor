require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :password }

  it { should have_many(:posts).dependent(:destroy) }
  it { should have_many(:courses).through(:course_passages) }
  it { should have_many(:course_passages).dependent(:destroy) }

  let!(:user)       { create :user }
  let!(:user_other) { create :user }
  let!(:admin) { create :user, admin: true }
  let!(:post)       { create :post, author: user }


  describe 'User.author_or_admin_of? check' do
    it 'is user the author of resource' do
      expect(user).to be_author_or_admin_of(post)
    end

    it 'is user not author of resource' do
      expect(user_other).to_not be_author_or_admin_of(post)
    end
  end

  describe 'User#not_admin check' do
    it 'return all user not admin' do
      users = User.not_admin

      users.each do |user|
        expect(user.admin).to be_falsey
      end
    end
  end

  describe 'User.full_name check' do
    it 'return full user name' do
      expect(user.full_name).to eq 'John Doe'
    end
  end
end
