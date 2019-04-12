require 'rails_helper'

feature 'Admin only can delete question', %q{
} do

  given(:user)  { create(:user) }
  given(:admin)  { create(:user, admin: true) }
  given!(:course) { create :course }
  given!(:modul) { create :modul, course: course }
  given!(:test) { create :test, modul: modul }
  given!(:question) { create :question, questionable: test, title: 'QuestionTitle' }
  given!(:answer) { create :answer, question: question }

  describe 'Admin' do
    background do
      sign_in(admin)
      visit test_path(test)
    end

    scenario 'can delete the question', js: true do
      expect(page).to have_content 'QuestionTitle'
      click_on 'Удалить вопрос'
      page.driver.browser.switch_to.alert.accept
      expect(page).to_not have_content 'QuestionTitle'
    end
  end

  describe 'Not admin' do
    background do
      sign_in(user)
      visit test_path(test)
    end

    scenario 'can not delete the question', js: true do
      expect(page).to_not have_button "Удалить вопрос"
    end
  end
end
