require 'rails_helper'

feature 'User can edit his post', %q{
} do

  given!(:user) { create(:user) }
  given!(:user2) { create(:user) }
  given!(:admin) { create(:user, admin: true) }
  given!(:post) { create :post, author: user, title: 'PostTitle' }

  describe "Unauthenticated user" do
    scenario 'can not edit post' do
      visit post_path(post)

      expect(page).to_not have_link 'Редактировать пост'
    end
  end

  describe 'Authenticated user' do
    scenario 'edit his post', js: true do
      sign_in user
      visit post_path(post)

      within '.post-edit-form' do
        click_on 'Редактировать пост'

        fill_in 'post[title]', with: 'Post Title New'
        tinymce_fill_in('post_body', 'Post Body New')
        click_on 'Опубликовать'
      end

      within 'article' do
        expect(page).to have_content 'Post Title New'
        expect(page).to_not have_content 'PostTitle'
      end
    end

    scenario 'edit his post with attach files', js: true do
      sign_in user
      visit post_path(post)

      within '.post-edit-form' do
        click_on 'Редактировать пост'

        fill_in 'post[title]', with: 'Post Title New'
        tinymce_fill_in('post_body', 'Post Body New')
        attach_file 'post_files', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]

        click_on 'Опубликовать'
      end

      within 'article' do
        expect(page).to have_content 'Post Title New'
        expect(page).to_not have_content 'PostTitle'
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
    end

    scenario "tries to edit other user's answer" do
      sign_in user2
      visit post_path(post)

      expect(page).to_not have_button 'Редактировать пост'
    end
  end

  scenario 'Admin can edit other user post', js: true do
    sign_in admin
    visit post_path(post)

    within '.post-edit-form' do
      click_on 'Редактировать пост'

      fill_in 'post[title]', with: 'Post Title New'
      tinymce_fill_in('post_body', 'Post Body New')
      click_on 'Опубликовать'
    end

    within 'article' do
      expect(page).to have_content 'Post Title New'
      expect(page).to_not have_content 'PostTitle'
    end
  end
end
