require 'rails_helper'

feature 'User can create post', %q{
} do

  given(:user) {create(:user) }

  describe 'Authenticate user' do
    background do
      sign_in(user)
      visit posts_path
    end

    scenario 'create an post', js: true do
      click_on 'Написать пост'

      fill_in 'post[title]', with: 'Post Title'
      tinymce_fill_in('post_body', 'Post Body')
      click_on 'Опубликовать'

      within '.card-deck' do
        expect(page).to have_content 'Post Body'
      end
    end

    scenario 'create an post with error', js: true do
      click_on 'Написать пост'
      click_on 'Опубликовать'

      expect(page).to have_content "Title не может быть пустым"
    end

    scenario 'is not admin can not create post for guests' do
      click_on 'Написать пост'

      expect(page).to_not have_field 'post[for_guests]'
    end

  end

  scenario 'Unauthenticated user tries to create an answer' do
    visit posts_path
    expect(page).to_not have_button('Написать пост')
  end
end
