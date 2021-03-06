require 'rails_helper'

feature "User can see all posts", %q{
} do

  given(:user) {create(:user) }
  given(:admin) {create(:user, admin: true) }
  given!(:posts) { create_list :post, 2, author: user }
  given!(:admin_posts) { create_list :post, 2, author: admin, body: 'Admin Body' }
  given!(:admin_posts_for_guests) { create_list :post, 2, author: admin, body: 'Posts for guests', for_guests: true }

  describe 'Authenticated user can see all posts' do
    before { sign_in(user) }

    scenario 'of all users in posts/' do
      visit posts_path

      posts.each do |post|
        expect(page).to have_content post.body
      end

      admin_posts.each do |post|
        expect(page).to have_content post.body
      end
    end

    scenario 'only of tutor in root_path' do
      visit root_path

      posts.each do |post|
        expect(page).to_not have_content post.body
      end

      admin_posts.each do |post|
        expect(page).to have_content post.body
      end
    end
  end

  describe 'Unauthenticated user' do
    scenario 'can not see posts of all users in posts/' do
      visit posts_path

      posts.each do |post|
        expect(page).to_not have_content post.body
      end

      admin_posts.each do |post|
        expect(page).to_not have_content post.body
      end
    end

    scenario 'can not see posts only of tutor in root_path' do
      visit root_path

      posts.each do |post|
        expect(page).to_not have_content post.body
      end

      admin_posts.each do |post|
        expect(page).to_not have_content post.body
      end
    end

    scenario 'can see posts only of guests' do
      visit guests_index_posts_path

      posts.each do |post|
        expect(page).to_not have_content post.body
      end

      admin_posts.each do |post|
        expect(page).to_not have_content post.body
      end

      admin_posts_for_guests.each do |post|
        expect(page).to have_content post.body
      end
    end
  end
end
