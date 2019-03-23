require 'rails_helper'

feature 'Admin only can create topic', %q{
} do

  given!(:admin) {create(:user, admin: true) }
  given!(:user) {create(:user) }
  given!(:course) {create(:course) }
  given!(:modul) {create(:modul, course: course) }

  describe 'Admin' do
    background do
      sign_in(admin)
      visit modul_path(modul)
    end

    scenario 'create a topic', js: true do
      click_on 'Создать новую тему'

      fill_in 'topic[title]', with: 'TopicTitle'
      tinymce_fill_in('topic_body', 'TopicBody')
      click_on 'Создать тему'

      within '.topics-list' do
        expect(page).to have_content 'TopicTitle'
      end
    end

    scenario 'create a topic with error', js: true do
      click_on 'Создать новую тему'
      click_on 'Создать тему'

      expect(page).to have_content "Заголовок не может быть пустым"
    end
  end

  scenario 'User can not create topic' do
    visit modul_path(modul)
    expect(page).to_not have_button "Создать новую тему"
  end

  scenario 'Unauthenticated user tries to create an topic' do
    visit modul_path(modul)
    expect(page).to_not have_button('Создать новую тему')
  end
end
