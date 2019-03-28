require 'rails_helper'

feature 'Admin only can create essay', %q{
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

    scenario 'create a essay', js: true do
      click_on 'Создать новое эссе'

      fill_in 'essay[title]', with: 'EssayTitle'
      click_on 'Создать эссе'

      within '.table-essays' do
        expect(page).to have_content 'EssayTitle'
      end
    end

    scenario 'create a essay with error', js: true do
      click_on 'Создать новое эссе'
      click_on 'Создать эссе'

      expect(page).to have_content "Заголовок не может быть пустым"
    end
  end

  scenario 'User can not create essay' do
    visit modul_path(modul)
    expect(page).to_not have_button "Создать новое эссе"
  end

  scenario 'Unauthenticated user tries to create an essay' do
    visit modul_path(modul)
    expect(page).to_not have_button('Создать новое эссе')
  end
end
