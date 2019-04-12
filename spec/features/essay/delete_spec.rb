require 'rails_helper'

feature 'Admin only can delete essay', %q{
} do

  given(:user)  { create(:user) }
  given(:admin)  { create(:user, admin: true) }
  given!(:course) { create :course }
  given!(:modul) { create :modul, course: course }
  given!(:essay) { create :essay, modul: modul, title: 'EssayTitle' }

  describe 'Admin' do
    background do
      sign_in(admin)
      visit essay_path(essay)
    end

    scenario 'can delete the essay', js: true do
      expect(page).to have_content 'EssayTitle'
      click_on 'Удалить эссе'
      page.driver.browser.switch_to.alert.accept
      expect(page).to_not have_content 'EssayTitle'
    end
  end

  describe 'Not admin' do
    background do
      sign_in(user)
      visit essay_path(essay)
    end

    scenario 'can not delete the essay', js: true do
      expect(page).to_not have_button "Удалить эссе"
    end
  end
end
