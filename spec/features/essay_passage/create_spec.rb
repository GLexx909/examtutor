require 'rails_helper'

feature 'User can create essay', %q{
} do

  given!(:admin) {create(:user, admin: true) }
  given!(:user) {create(:user) }
  given!(:course) {create(:course) }
  given!(:modul) {create(:modul, course: course) }
  given!(:essay) {create(:essay, modul: modul) }

  describe 'User' do
    background do
      sign_in(user)
      visit essay_path(essay)
    end

    scenario 'create a essay', js: true do
      click_on 'Написать эссе'
      tinymce_fill_in('essay_passage_body', 'EssayBody')

      click_on 'Сохранить'

      within '.essay-passage__body' do
        expect(page).to have_content 'EssayBody'
      end
    end

    context 'multiple session', js: true do
      scenario "notification appears on pupil's page" do
        Capybara.using_session('user') do
          sign_in(user)
          visit essay_path(essay)
        end

        Capybara.using_session('admin') do
          sign_in(admin)
          visit essay_path(essay)
        end

        Capybara.using_session('user') do
          click_on 'Написать эссе'
          tinymce_fill_in 'essay_passage_body', with: 'EssayTitle'

          click_on 'Сохранить'
          click_on 'Отправить репетитору на проверку'

          expect(page).to have_content 'Уведомление отправлено репетитору!'
        end

        Capybara.using_session('admin') do
          within '.notifications-dropdown' do
            click_on 'Toggle Dropleft'
            expect(page).to have_content 'На проверку эссе от John Doe'
          end

          click_on 'На проверку эссе от John Doe'
          click_on 'Уведомить ученика об окончании проверки'
        end

        Capybara.using_session('user') do
          within '.notifications-dropdown' do
            click_on 'Toggle Dropleft'
            expect(page).to have_content 'Ваше эссе проверено'
          end
        end
      end
    end
  end
end

