require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }

  it { should belong_to :author }

  let(:user) { create :user, admin: true }
  let(:posts) { create_list :post, 2, author: user }
  let(:user_other) { create :user }
  let(:posts_other) { create_list :post, 2, author: user_other }
  let(:posts_for_guests) { create_list :post, 2, author: user, for_guests: true }

  describe '#of_admin check' do
    it "all posts must be admin's" do
      posts = Post.of_admin
      posts.each do |post|
        expect(post.author.admin).to be_truthy
      end
    end
  end

  describe '#of_user check' do
    it "all posts must be user's" do
      posts = Post.of_user(user)
      posts.each do |post|
        expect(post.author == user).to be_truthy
      end
    end
  end

  describe '#for_guests check' do
    it "all posts must for guests" do
      posts = Post.for_guests
      posts.each do |post|
        expect(post.for_guests?).to be_truthy
      end
    end
  end
end
