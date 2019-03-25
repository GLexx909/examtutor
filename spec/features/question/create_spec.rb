require 'rails_helper'

feature 'Admin only can create test', %q{
} do

  given!(:admin) {create(:user, admin: true) }
  given!(:user) {create(:user) }
  given!(:course) {create(:course) }
  given!(:modul) {create(:modul, course: course) }
  given!(:test) {create(:test, modul: modul) }

  describe 'Admin' do
    background do
      sign_in(admin)
      visit test_path(test)
    end

    scenario 'create a question', js: true do
      click_on 'Создать новый вопрос'

      fill_in 'question[title]', with: 'QuestionTitle'
      click_on 'Создать вопрос'

      expect(page).to have_content 'QuestionTitle'
    end

    scenario 'create a question with error', js: true do
      click_on 'Создать новый вопрос'
      click_on 'Создать вопрос'

      expect(page).to have_content "Заголовок не может быть пустым"
    end
  end

  scenario 'User can not create question' do
    visit test_path(test)
    expect(page).to_not have_button "Создать новый вопрос"
  end

  scenario 'Unauthenticated user tries to create an question' do
    visit test_path(test)
    expect(page).to_not have_button('Создать новый вопрос')
  end
end
