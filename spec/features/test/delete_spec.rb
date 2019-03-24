require 'rails_helper'

feature 'Admin only can delete test', %q{
} do

  given(:user)  { create(:user) }
  given(:admin)  { create(:user, admin: true) }
  given!(:course) { create :course }
  given!(:modul) { create :modul, course: course }
  given!(:test) { create :test, modul: modul, title: 'TestTitle' }

  describe 'Admin' do
    background do
      sign_in(admin)
      visit test_path(test)
    end

    scenario 'can delete the test', js: true do
      expect(page).to have_content 'TestTitle'
      click_on 'Удалить тест'
      expect(page).to_not have_content 'TestTitle'
    end
  end

  describe 'Not admin' do
    background do
      sign_in(user)
      visit test_path(test)
    end

    scenario 'can not delete the test', js: true do
      expect(page).to_not have_button "Удалить тест"
    end
  end
end
