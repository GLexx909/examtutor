require 'rails_helper'

feature 'User can delete his comment', %q{
} do

  given!(:user) {create(:user) }
  given!(:user_other) {create(:user) }
  given!(:admin) {create(:user, admin: true) }
  given!(:post) {create(:post, author: user) }
  given!(:comment) {create(:comment, author: user, post: post, body: 'CommentBody') }

  describe 'Author' do
    background do
      sign_in(user)
      visit post_path(post)
    end

    scenario 'can delete the comment', js: true do
      within '.comments-list' do
        click_on 'Удалить'
        expect(page).to have_content 'CommentBody'
      end
    end
  end

  describe 'Not author' do
    background do
      sign_in(user_other)
      visit post_path(post)
    end

    scenario 'can not delete a comment' do
      expect(page).to_not have_button('Удалить')
    end
  end

  describe 'Admin' do
    background do
      sign_in(admin)
      visit post_path(post)
    end

    scenario 'can delete the comment', js: true do
      within '.comments-list' do
        click_on 'Удалить'
        expect(page).to_not have_content 'CommentBody'
      end
    end
  end
end
