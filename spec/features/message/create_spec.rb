require 'rails_helper'

feature 'User can create message', %q{
} do

  given!(:admin) {create(:user, admin: true) }
  given!(:user) {create(:user) }
  given!(:user2) {create(:user) }
  given!(:characteristic)  { create :characteristic, user: user2, points: 50 }

  describe 'User' do
    background do
      sign_in(user)
      visit profile_path(user2)
    end

    scenario 'create a message', js: true do
      click_on 'Написать сообщение'

      tinymce_fill_in('message_body', 'NewMessage')
      click_on 'Отправить'
    end

    scenario 'create a message with error', js: true do
      click_on 'Написать сообщение'

      tinymce_fill_in('message_body', '')
      click_on 'Отправить'
      expect(page).to have_content "Сообщение не может быть пустым"
    end
  end
end
