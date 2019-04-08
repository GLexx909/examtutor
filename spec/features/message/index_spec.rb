require 'rails_helper'

feature 'Admin only can see messages list and create new message', %q{
} do

  given!(:admin) {create(:user, admin: true) }
  given!(:user) {create(:user) }
  given!(:user2) {create(:user) }

  describe 'User' do
    background do
      sign_in(user)
      visit messages_path(abonent_id: user2)
    end

    scenario 'create a message', js: true do
      tinymce_fill_in('message_body', 'NewMessage')
      click_on 'Отправить'

      expect(page).to have_content "NewMessage"
    end

    scenario 'create a message with error', js: true do
      tinymce_fill_in('message_body', '')
      click_on 'Отправить'
      expect(page).to have_content "Сообщение не может быть пустым"
    end
  end

  context 'multiple session', js: true do
    scenario "message appears on other user's page" do
      Capybara.using_session('user') do
        sign_in(user)
        visit messages_path(abonent_id: user2)
      end

      Capybara.using_session('user2') do
        sign_in(user2)
        visit messages_path(abonent_id: user)
      end

      Capybara.using_session('user') do
        tinymce_fill_in('message_body', 'NewMessage')
        click_on 'Отправить'

        expect(page).to have_content "NewMessage"
      end

      Capybara.using_session('user2') do
        expect(page).to have_content 'NewMessage'

        tinymce_fill_in('message_body', 'NewMessage2')
        click_on 'Отправить'
      end

      Capybara.using_session('user') do
        expect(page).to have_content 'NewMessage2'
      end
    end
  end
end
