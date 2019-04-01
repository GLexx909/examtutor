require 'rails_helper'

feature 'User can send test_passage to tutor', %q{
} do

  given!(:admin) {create(:user, admin: true) }
  given!(:user) {create(:user) }
  given!(:course) {create(:course) }
  given!(:modul) {create(:modul, course: course) }
  given!(:test) {create(:test, modul: modul) }
  given!(:question) {create(:question, questionable: test) }
  given!(:answer) {create(:answer, question: question, body: '123') }

  context 'multiple session', js: true do
    scenario "notification appears on tutor's page" do
      Capybara.using_session('user') do
        sign_in(user)
        visit start_test_path(test)
      end

      Capybara.using_session('admin') do
        sign_in(admin)
        visit test_path(test)
      end

      Capybara.using_session('user') do
        click_on 'Ответить'
        click_on 'Отправить репетитору на проверку'

        expect(page).to have_content 'Уведомление отправлено репетитору!'
      end

      Capybara.using_session('admin') do
        within '.notifications-dropdown' do
          click_on 'Toggle Dropleft'
          expect(page).to have_content 'На проверку тест от John Doe'
        end
      end
    end
  end
end

