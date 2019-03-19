require 'rails_helper'

feature "User can edit own profile", %q{
} do

  given(:user) {create(:user) }
  given(:admin) {create(:user, admin: true) }

  describe 'Authenticated user' do
    before { sign_in(user) }

    scenario 'can edit his profile', js: true do
      visit edit_profile_path(user)

      click_on 'Редактировать'
      fill_in'user[first_name]', with: 'NewFirstName'
      click_on 'Сохранить изменения'

      within('.profile-info') do
        expect(page).to have_content('NewFirstName')
      end
    end

    scenario 'can not edit other user profile', js: true do
      visit edit_profile_path(admin)

      expect(page).to_not have_button('Редактировать')
    end
  end

  describe 'Admin' do
    before { sign_in(admin) }

    scenario 'can edit other user profile', js: true do
      visit edit_profile_path(user)

      click_on 'Редактировать'
      fill_in'user[first_name]', with: 'NewFirstName'
      click_on 'Сохранить изменения'

      within('.profile-info') do
        expect(page).to have_content('NewFirstName')
      end
    end
  end
end
