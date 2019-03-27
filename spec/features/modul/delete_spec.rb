require 'rails_helper'

feature 'Admin only can delete modul', %q{
} do

  given(:user)  { create(:user) }
  given(:admin)  { create(:user, admin: true) }
  given!(:course) { create :course }
  given!(:modul) { create :modul, course: course }

  describe 'Admin' do
    background do
      sign_in(admin)
      visit course_path(course)
    end

    scenario 'can delete the modul', js: true do
      within '.moduls-list' do
        expect(page).to have_content 'ModulTitle'
        click_on 'Удалить модуль'
        expect(page).to_not have_content 'ModulTitle'
      end
    end
  end

  describe 'Not admin' do
    background do
      sign_in(user)
      visit course_path(course)
    end

    scenario 'can not delete the modul', js: true do
      expect(page).to_not have_button "Удалить модуль"
    end
  end
end
