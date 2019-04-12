require 'rails_helper'

feature 'Admin only can delete topic', %q{
} do

  given(:user)  { create(:user) }
  given(:admin)  { create(:user, admin: true) }
  given!(:course) { create :course }
  given!(:modul) { create :modul, course: course }
  given!(:topic) { create :topic, modul: modul, title: 'TopicTitle' }

  describe 'Admin' do
    background do
      sign_in(admin)
      visit topic_path(topic)
    end

    scenario 'can delete the topic', js: true do
      expect(page).to have_content 'TopicTitle'
      click_on 'Удалить тему'
      page.driver.browser.switch_to.alert.accept
      expect(page).to_not have_content 'TopicTitle'
    end
  end

  describe 'Not admin' do
    background do
      sign_in(user)
      visit topic_path(topic)
    end

    scenario 'can not delete the topic', js: true do
      expect(page).to_not have_button "Удалить модуль"
    end
  end
end
