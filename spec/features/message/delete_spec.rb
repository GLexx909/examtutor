require 'rails_helper'

feature 'User can delete his own message', %q{
} do

  given!(:admin) {create(:user, admin: true) }
  given!(:user) {create(:user) }
  given!(:user2) {create(:user) }
  given!(:message) {create(:message, author: user, abonent: user2, body: 'NewMessage')}
  given!(:message2) {create(:message, author: user, abonent: admin, body: 'NewMessage')}

  describe 'User author' do
    background do
      sign_in(user)
      visit messages_path(abonent_id: user2)
    end

    scenario 'delete his message', js: true do
      within ".message-#{message.id}" do
        click_on 'Удалить'
        expect(page).to_not have_content "NewMessage"
      end
    end
  end

  describe 'User not author' do
    background do
      sign_in(user2)
      visit messages_path(abonent_id: user)
    end

    scenario 'can not delete someone else is message', js: true do
      within ".message-#{message.id}" do

        expect(page).to_not have_link "Удалить"
      end
    end
  end

  describe 'Admin' do
    background do
      sign_in(admin)
      visit messages_path(abonent_id: user)
    end

    scenario 'can delete someone else is message', js: true do
      within ".message-#{message2.id}" do

        expect(page).to have_link "Удалить"
      end
    end
  end
end
