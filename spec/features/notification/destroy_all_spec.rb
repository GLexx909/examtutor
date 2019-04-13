require 'rails_helper'

feature 'User can delete all notifications', %q{
  Where user is abonent
} do

  given(:user)  { create(:user) }
  given(:admin)  { create(:user, admin: true) }
  given!(:notifications) { create_list :notification, 3, author: admin, abonent: user, title: 'Notification to user' }


  describe 'Author' do
    background do
      sign_in(user)
      visit notifications_path
    end

    scenario 'can delete all notification', js: true do
      expect(page).to have_content 'Notification to user'

      click_on 'Удалить все уведомления'

      expect(page).to_not have_content 'Notification to user'
    end
  end
end
