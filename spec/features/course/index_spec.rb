require 'rails_helper'

feature 'User can see his courses list', %q{
  User can see only his courses
  Courses he has subscribed by tutor
} do

  given!(:user) { create(:user) }
  given!(:courses) { create_list :course, 3 }

  scenario 'User can see questions list' do
    sign_in(user)
    visit courses_path

    courses.each do |course|
      expect(page).to have_content course.title
    end
  end
end
