require 'rails_helper'

feature 'User can see pelpals', %q{
} do

  given!(:admin) {create(:user, admin: true, first_name: 'Admin') }
  given!(:user) {create(:user) }
  given!(:message) {create(:message, author: admin, abonent: user, body: 'Hello') }

  describe 'User' do
    background do
      sign_in(user)
      visit abonents_messages_path
    end

    scenario 'see pelpals list', js: true do
      expect(page).to have_content admin.full_name
    end
  end

  describe 'Admin' do
    background do
      sign_in(admin)
      visit abonents_messages_path
    end

    scenario 'see pelpals list', js: true do
      expect(page).to have_content user.full_name
    end
  end
end

