require 'rails_helper'

feature 'Admin only can edit user attendance', %q{
} do

  given!(:user) {create(:user, first_name: 'Boris') }
  given!(:admin) {create(:user, admin: true) }
  given!(:attendance) {create(:attendance, user: user) }

  describe 'Admin' do
    background do
      sign_in(admin)
      visit edit_attendance_path(attendance)
    end

    scenario 'edit an attendance', js: true do
      select user.full_name, from: 'attendance_user_id'
      fill_in 'attendance_description', with: 'New Description'
      click_on 'Изменить посещение'

      expect(page).to have_content 'Посещение успешно изменено!'
    end

    scenario 'edit an attendance with error', js: true do
      select user.full_name, from: 'attendance_user_id'
      fill_in 'attendance_description', with: ''
      click_on 'Изменить посещение'

      expect(page).to have_content 'Описание не может быть пустым'
    end
  end

  scenario 'User can not edit attendance' do
    visit edit_attendance_path(attendance)
    expect(page).to_not have_button "Изменить посещение"
  end
end
