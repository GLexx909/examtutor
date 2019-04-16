require 'rails_helper'

feature 'Admin only can create user progress', %q{
} do

  given!(:user) {create(:user, first_name: 'Boris') }
  given!(:admin) {create(:user, admin: true) }

  describe 'Admin' do
    background do
      sign_in(admin)
      visit new_progress_path
    end

    scenario 'create an progress', js: true do
      select user.full_name, from: 'progress[user_id]'
      fill_in 'progress[points]', with: 35
      select 'апреля', from: 'progress[date(2i)]'
      select '2019', from: 'progress[date(1i)]'

      click_on 'Создать'

      expect(page).to have_content 'Успеваемость успешно добавлена!'
    end

    scenario 'create an progress with error', js: true do
      select user.full_name, from: 'progress[user_id]'
      select 'апреля', from: 'progress[date(2i)]'
      select '2019', from: 'progress[date(1i)]'

      click_on 'Создать'

      expect(page).to have_content 'Очки не может быть пустым'
    end
  end

  scenario 'User can not create progress' do
    visit new_progress_path

    expect(page).to_not have_button "Создать"
  end
end
