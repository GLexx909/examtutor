require 'rails_helper'

feature 'Only admin can delete profiles list', %q{
} do

  given!(:user) { create(:user) }
  given!(:user2) { create(:user, first_name: 'Alex') }
  given!(:admin) { create(:user, admin: true, first_name: 'Admin') }

  scenario 'Admin can delete user', js: true do
    sign_in(admin)
    visit profiles_path

    within ".user-#{user.id}" do
      click_on('Удалить')
    end
    page.driver.browser.switch_to.alert.accept

    expect(page).to_not have_content user.full_name
  end

  scenario 'User can not delete other user' do
    sign_in(user)
    visit profiles_path

    within ".user-#{user2.id}" do
      expect(page).to_not have_button 'Удалить'
    end
  end
end
