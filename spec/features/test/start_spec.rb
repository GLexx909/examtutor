require 'rails_helper'

feature 'User can take the test', %q{
} do

  given!(:user) {create(:user) }
  given!(:characteristic)  { create :characteristic, user: user, points: 50 }
  given!(:course) {create(:course) }
  given!(:modul) {create(:modul, course: course) }
  given!(:modul_passage) { create :modul_passage, modul: modul, user: user, status: true }
  given!(:test)  { create :test, modul: modul }
  given!(:question) { create :question, questionable: test, title: 'Question number 1' }
  given!(:answer) { create :answer, question: question, body: '123' }

  describe 'User' do
    background do
      sign_in(user)
    end

    scenario 'can start the test', js: true do
      visit modul_path(modul)
      click_on 'Пройти'

      expect(page).to have_content 'Question number 1'
      # expect(page).to have_css 'input[name="answer"]'
      # expect(page).to have_css 'input[name="commit"]'
      expect(page).to have_button 'Ответить'
    end

    scenario 'can give the answer for the question', js: true do
      visit start_test_path(test)


      fill_in 'answer', with: '345'
      click_on 'Ответить'

      expect(page).to have_content '123'
      expect(page).to have_content '345'
    end
  end

end
