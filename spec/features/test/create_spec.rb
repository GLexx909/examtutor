require 'rails_helper'

feature 'Admin only can create test', %q{
} do

  given!(:admin) {create(:user, admin: true) }
  given!(:user) {create(:user) }
  given!(:course) {create(:course) }
  given!(:modul) {create(:modul, course: course) }

  describe 'Admin' do
    background do
      sign_in(admin)
      visit modul_path(modul)
    end

    scenario 'create a test', js: true do
      click_on 'Создать новый тест'

      fill_in 'test[title]', with: 'EssayTitle'
      fill_in 'test[timer]', with: '1'
      click_on 'Создать тест'

      within '.table-tests' do
        expect(page).to have_content 'EssayTitle'
      end
    end

    scenario 'create a test with error', js: true do
      click_on 'Создать новый тест'
      click_on 'Создать тест'

      expect(page).to have_content "Заголовок не может быть пустым"
    end
  end

  scenario 'User can not create test' do
    visit modul_path(modul)
    expect(page).to_not have_button "Создать новый тест"
  end

  scenario 'Unauthenticated user tries to create an test' do
    visit modul_path(modul)
    expect(page).to_not have_button('Создать новый тест')
  end
end
