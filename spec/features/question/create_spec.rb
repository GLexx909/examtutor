require 'rails_helper'

feature 'Admin only can create question', %q{
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

      tinymce_fill_in('question_title', 'QuestionTitle')
      fill_in 'question[answer_attributes][body]', with: 'AnswerBody'
      fill_in 'question[answer_attributes][points]', with: 3

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
