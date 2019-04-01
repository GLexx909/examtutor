require 'rails_helper'

feature 'Admin only can edit question', %q{
} do

  given!(:user) { create(:user) }
  given!(:admin) { create(:user, admin: true) }
  given!(:course) { create :course }
  given!(:modul) { create :modul, course: course  }
  given!(:test) { create :test, modul: modul }
  given!(:question) { create :question, questionable: test, title: 'QuestionTitle'  }
  given!(:answer) { create :answer, question: question }


  describe "Unauthenticated user" do
    scenario 'can not edit question' do
      visit test_path(test)

      expect(page).to_not have_link 'Редактировать вопрос'
    end
  end

  describe 'Authenticated user' do
    scenario 'can not edit question', js: true do
      sign_in user
      visit test_path(test)

      expect(page).to_not have_button 'Редактировать вопрос'
    end
  end

  scenario 'Admin can edit question', js: true do
    sign_in admin
    visit test_path(test)

    click_on 'Редактировать вопрос'

    tinymce_fill_in('question_title', 'Question New Title')
    click_on 'Сохранить изменения'

    expect(page).to have_content 'Question New Title'
    expect(page).to_not have_content 'QuestionTitle'
  end
end
