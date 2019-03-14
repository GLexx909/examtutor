require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to :user }

  let(:user) { create :user, admin: true }
  let(:posts) { create_list :post, 5, user: user }

  describe '#of_admin check' do
    it "all posts must be admin's" do
      posts.each do |post|
        expect(post.user.admin).to be_truthy
      end
    end
  end
end
