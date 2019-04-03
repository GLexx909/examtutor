require 'rails_helper'

feature 'Admin only can create course_passage', %q{
  Admin be able to enroll the user in the course
} do

  given!(:user) {create(:user) }
  given!(:admin) {create(:user, admin: true, first_name: 'Admin') }
  given!(:course) { create(:course) }
  let!(:modul)  { create :modul, course: course }
  # let!(:modul_passage)  { create :modul_passage, modul: modul, user: user, status: true }

  describe 'Admin' do
    background do
      sign_in(admin)
      visit new_course_passage_path
    end

    scenario 'create a course_passage', js: true do
      select 'John Doe', from: 'course_passage[user_id]'
      select 'CourseTitle', from: 'course_passage[course_id]'

      click_on 'Добавить ученика'

      expect(page).to have_content 'John Doe добавлен к курсу CourseTitle'
    end
  end

  scenario 'User can not create course' do
    sign_in(user)
    visit new_course_passage_path
    expect(page).to_not have_select "course_passage[user_id]"
  end

  scenario 'Unauthenticated user tries to create an answer' do
    visit new_course_passage_path
    expect(page).to_not have_select "course_passage[user_id]"
  end
end
