require 'rails_helper'
# User can create post, but button was hide. And now user can not write posts, but admin can.
feature 'User can create post', %q{
} do

  given(:user) {create(:user, admin: true) }

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

      expect(page).to have_content "Заголовок не может быть пустым"
    end

    # scenario 'is not admin can not create post for guests' do
    #   click_on 'Написать пост'
    #
    #   expect(page).to_not have_field 'post[for_guests]'
    # end

  end

  scenario 'Unauthenticated user tries to create an answer' do
    visit posts_path
    expect(page).to_not have_button('Написать пост')
  end

  scenario 'create a post with attached file', js: true do
    sign_in(user)
    visit posts_path

    click_on 'Написать пост'

    fill_in 'post[title]', with: 'Post Title'
    tinymce_fill_in('post_body', 'Post Body')
    attach_file 'post_files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]

    click_on 'Опубликовать'
  end
end
