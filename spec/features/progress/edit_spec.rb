require 'rails_helper'

feature 'Admin only can edit user progress', %q{
} do

  given!(:user) {create(:user, first_name: 'Boris') }
  given!(:admin) {create(:user, admin: true) }
  given!(:progress) {create(:progress, user: user, date: 'Апрель 2019', points: 35) }


  describe 'Admin' do
    background do
      sign_in(admin)
      visit edit_progress_path(progress)
    end

    scenario 'edit an progress', js: true do
      select user.full_name, from: 'progress[user_id]'
      fill_in 'progress[points]', with: 44
      select '1', from: 'progress[date(2i)]'
      select '2019', from: 'progress[date(1i)]'

      click_on 'Изменить'

      expect(page).to have_content 'Успеваемость успешно изменена!'
    end

    scenario 'edit an progress with error', js: true do
      select user.full_name, from: 'progress[user_id]'
      fill_in 'progress[points]', with: ''
      select '1', from: 'progress[date(2i)]'
      select '2019', from: 'progress[date(1i)]'

      click_on 'Изменить'

      expect(page).to have_content 'Очки не может быть пустым'
    end
  end

  scenario 'User can not edit progress' do
    visit edit_progress_path(progress)

    expect(page).to_not have_button "Изменить"
  end
end
