require 'rails_helper'

feature 'Admin only can delete course', %q{
} do

  given(:user)  { create(:user) }
  given(:admin)  { create(:user, admin: true) }
  given!(:course) { create :course }


  describe 'Admin' do
    background do
      sign_in(admin)
      visit courses_path
    end

    scenario 'can delete the course', js: true do
      within '.courses-list' do
        expect(page).to have_content 'CourseTitle'
        click_on 'Удалить курс'
        page.driver.browser.switch_to.alert.accept
        expect(page).to_not have_content 'CourseTitle'
      end
    end
  end

  describe 'Not admin' do
    background do
      sign_in(user)
      visit courses_path
    end

    scenario 'can not delete the course', js: true do
      expect(page).to_not have_button "Удалить курс"
    end
  end
end
