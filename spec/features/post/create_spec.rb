require 'rails_helper'

feature 'User can create post', %q{
} do

  given(:user) {create(:user) }
  # given!(:question) { create :question, author: user }


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

    # scenario 'create an answer with attached file', js: true do
    #   fill_in 'Body', with: 'text text text'
    #
    #   attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
    #   click_on 'Post Your Answer'
    #
    #   expect(page).to have_link 'rails_helper.rb'
    #   expect(page).to have_link 'spec_helper.rb'
    # end
  end

  scenario 'Unauthenticated user tries to create an answer' do
    visit posts_path
    expect(page).to_not have_button('Написать пост')
  end
end
