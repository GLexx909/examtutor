require 'rails_helper'

feature 'Admin only can edit answer', %q{
} do

  given!(:user) { create(:user) }
  given!(:admin) { create(:user, admin: true) }
  given!(:course) { create :course }
  given!(:modul) { create :modul, course: course  }
  given!(:test) { create :test, modul: modul }
  given!(:question) { create :question, questionable: test  }
  given!(:answer) { create :answer, question: question, body: 'AnswerBody'  }

  describe "Unauthenticated user" do
    scenario 'can not edit answer' do
      visit test_path(test)

      expect(page).to_not have_link 'Редактировать ответ'
    end
  end

  describe 'Authenticated user' do
    scenario 'can not edit answer', js: true do
      sign_in user
      visit test_path(test)

      expect(page).to_not have_button 'Редактировать ответ'
    end
  end

  scenario 'Admin can edit answer', js: true do
    sign_in admin
    visit test_path(test)

    click_on 'Редактировать вопрос'
    # expect(page).to have_selector("input[name='question[answer_attributes][body]']")
    fill_in 'question[answer_attributes][body]', with: 'Answer Body New'
    # tinymce_fill_in('question_title', 'Question Title')
    sleep 2

    click_on 'Сохранить изменения вопроса'
    expect(page).to have_content 'Answer Body New'
    expect(page).to_not have_content 'AnswerBody'
  end
end
