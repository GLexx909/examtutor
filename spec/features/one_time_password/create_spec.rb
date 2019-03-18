require 'rails_helper'

feature 'Only admin can create one_time_password', %q{
} do

  given(:admin) { create(:user, admin: true) }
  given(:user) { create(:user) }

  describe 'Admin can create one_time_password' do
    background do
      sign_in(admin)
      visit admin_mainmenus_path
    end

    scenario 'with valid attributes', js: true do
      page.execute_script("$('.admin-sidebar-left__full').show();")
      find(".link-call-password-form").click

      fill_in 'one_time_password[pass_word]', with: '123456'
      click_on 'Создать'

      expect(page).to have_content 'Пароль успешно создан'
    end

    scenario 'with invalid attributes', js: true do
      page.execute_script("$('.admin-sidebar-left__full').show();")
      find(".link-call-password-form").click

      fill_in 'one_time_password[pass_word]', with: ''
      click_on 'Создать'

      expect(page).to have_content 'Pass word не может быть пустым'
    end
  end

  scenario 'Not admin tries to create password' do
    sign_in(user)
    visit admin_mainmenus_path

    expect(page).to have_content('You are not authorized to access this page.')
  end
end
