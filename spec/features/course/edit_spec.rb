require 'rails_helper'

feature 'Admin only can edit course', %q{
} do

  given!(:user) { create(:user) }
  given!(:admin) { create(:user, admin: true) }
  given!(:course) { create :course, title: 'CourseTitle' }

  describe "Unauthenticated user" do
    scenario 'can not edit course' do
      visit courses_path

      expect(page).to_not have_link 'Редактировать'
    end
  end

  describe 'Authenticated user' do
    scenario 'can not edit course', js: true do
      sign_in user
      visit courses_path

      expect(page).to_not have_button 'Редактировать'
    end
  end

  scenario 'Admin can edit courses', js: true do
    sign_in admin
    visit courses_path

    click_on 'Редактировать'

    fill_in 'course[title]', with: 'Course Title New'
    click_on 'Сохранить изменения'

    expect(page).to have_content 'Course Title New'
    expect(page).to_not have_content 'CourseTitle'
  end
end
