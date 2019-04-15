require 'rails_helper'

feature 'Admin only can create user attendance', %q{
} do

  given!(:user) {create(:user, first_name: 'Boris') }
  given!(:admin) {create(:user, admin: true) }

  describe 'Admin' do
    background do
      sign_in(admin)
      visit new_attendance_path
    end

    scenario 'create an attendance', js: true do
      select user.full_name, from: 'attendance_user_id'
      fill_in 'attendance_description', with: 'Description'
      click_on 'Добавить посещение'

      expect(page).to have_content 'Посещение успешно добавлено!'
    end

    scenario 'create an attendance with error', js: true do
      click_on 'Добавить посещение'

      expect(page).to have_content 'Описание не может быть пустым'
      expect(page).to have_content "Ученик не может быть пустым"
    end
  end

  scenario 'User can not create attendance' do
    expect(page).to_not have_button "Добавить посещение"
  end

  scenario 'Unauthenticated user tries to create an course' do
    visit posts_path
    expect(page).to_not have_button('Добавить посещение')
  end
end
