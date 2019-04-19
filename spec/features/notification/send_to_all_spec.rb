require 'rails_helper'

feature 'Only admin can send notification to all', %q{
} do

  given!(:admin) {create(:user, admin: true) }
  given!(:user) {create(:user) }

  describe 'Admin' do
    background do
      sign_in(admin)
      visit notifications_path
    end

    scenario 'can send notification to all', js: true do
      fill_in 'title[]', with: 'New notification'
      click_on 'Отправить всем'

      expect(page).to have_content 'Уведомления успешно отправлены!'
    end

    context 'multiple session', js: true do
      scenario "notification appears on pupil's page" do

        Capybara.using_session('admin') do
          sign_in(admin)
          visit notifications_path
        end

        Capybara.using_session('user') do
          sign_in(user)
          visit root_path
        end

        Capybara.using_session('admin') do
          fill_in 'title[]', with: 'New notification'
          click_on 'Отправить всем'

          expect(page).to have_content 'Уведомления успешно отправлены!'
        end

        Capybara.using_session('user') do
          within '.notifications-dropdown' do
            click_on 'Toggle Dropleft'
            expect(page).to have_content 'New notification'
          end
        end
      end
    end
  end

  describe 'User' do
    background do
      sign_in(user)
      visit notifications_path
    end

    scenario 'can not send notification to all', js: true do
      expect(page).to_not have_button 'Отправить всем'
    end
  end
end
