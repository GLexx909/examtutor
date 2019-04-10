require 'rails_helper'

feature 'User can create comment', %q{
} do

  given!(:user) {create(:user) }
  given!(:post) {create(:post, author: user) }

  describe 'Admin' do
    background do
      sign_in(user)
      visit post_path(post)
    end

    scenario 'create a comment', js: true do
      fill_in 'comment[body]', with: 'CommentBody'
      click_on 'Опубликовать комментарий'

      within '.comments-list' do
        expect(page).to have_content 'CommentBody'
      end
    end

    scenario 'create a comment with error', js: true do
      fill_in 'comment[body]', with: ''
      click_on 'Опубликовать комментарий'

      expect(page).to_not have_content 'CommentBody'

      expect(page).to have_content "Комментарий не может быть пустым"
    end
  end

  scenario 'Unauthenticated user can not create a comment' do
    visit post_path(post)
    expect(page).to_not have_button('Опубликовать комментарий')
  end
end
