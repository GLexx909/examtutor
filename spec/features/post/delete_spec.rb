require 'rails_helper'

feature 'User can delete post', %q{
} do

  given(:user)  { create(:user) }
  given(:admin)  { create(:user, admin: true) }
  given!(:post) { create :post, author: user }


  describe 'Author' do
    background do
      sign_in(user)
      visit posts_path
    end

    scenario 'can delete the post', js: true do
      within '.card-deck' do
        expect(page).to have_content 'Post Body'
        click_on 'Удалить пост'
        expect(page).to_not have_content 'Post Body'
      end
    end
  end

  describe 'Not author' do
    background do
      sign_in(user)
      visit posts_path
    end

    scenario 'can not delete the post', js: true do
      click_on 'Написать пост'
      click_on 'Опубликовать'

      expect(page).to have_content "Title не может быть пустым"
    end
  end

  describe 'Admin' do
    background do
      sign_in(admin)
      visit posts_path
    end

    scenario 'can delete the post of other users', js: true do
      within '.card-deck' do
        expect(page).to have_content 'Post Body'
        click_on 'Удалить пост'
        expect(page).to_not have_content 'Post Body'
      end
    end
  end
  # scenario 'create an answer with attached file', js: true do
  #   fill_in 'Body', with: 'text text text'
  #
  #   attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
  #   click_on 'Post Your Answer'
  #
  #   expect(page).to have_link 'rails_helper.rb'
  #   expect(page).to have_link 'spec_helper.rb'
  # end

  scenario 'Unauthenticated user can not delete a post' do
    visit posts_path
    expect(page).to_not have_button('Удалить пост')
  end
end
