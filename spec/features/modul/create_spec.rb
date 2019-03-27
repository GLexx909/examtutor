require 'rails_helper'

feature 'Admin only can create modul', %q{
} do

  given!(:admin) {create(:user, admin: true) }
  given!(:user) {create(:user) }
  given!(:course) {create(:course) }

  describe 'Admin' do
    background do
      sign_in(admin)
      visit course_path(course)
    end

    scenario 'create a modul', js: true do
      click_on 'Создать новый модуль'

      fill_in 'modul[title]', with: 'ModulTitle'
      click_on 'Создать модуль'

      within '.moduls-list' do
        expect(page).to have_content 'ModulTitle'
      end
    end

    scenario 'create a modul with error', js: true do
      click_on 'Создать новый модуль'
      click_on 'Создать модуль'

      expect(page).to have_content "Заголовок не может быть пустым"
    end
  end

  scenario 'User can not create modul' do
    visit course_path(course)
    expect(page).to_not have_button "Создать новый модуль"
  end

  scenario 'Unauthenticated user tries to create an modul' do
    visit course_path(course)
    expect(page).to_not have_button('Создать новый модуль')
  end
end
