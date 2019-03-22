require 'rails_helper'

feature 'Admin only can create course', %q{
} do

  given!(:admin) {create(:user, admin: true) }
  given!(:user) {create(:user) }

  describe 'Admin' do
    background do
      sign_in(admin)
      visit courses_path
    end

    scenario 'create a course', js: true do
      click_on 'Создать новый курс'

      fill_in 'course[title]', with: 'CourseTitle'
      click_on 'Создать'

      within '.courses-list' do
        expect(page).to have_content 'CourseTitle'
      end
    end

    scenario 'create a course with error', js: true do
      click_on 'Создать новый курс'
      click_on 'Создать'

      expect(page).to have_content "Заголовок не может быть пустым"
    end
  end

  scenario 'User can not create course' do
    expect(page).to_not have_button "Создать новый курс"
  end

  scenario 'Unauthenticated user tries to create an answer' do
    visit posts_path
    expect(page).to_not have_button('Написать пост')
  end
end
