require 'rails_helper'

feature 'Admin only can edit modul', %q{
} do

  given!(:user) { create(:user) }
  given!(:admin) { create(:user, admin: true) }
  given!(:course) { create :course }
  given!(:modul) { create :modul, title: 'ModulTitle', course: course  }

  describe "Unauthenticated user" do
    scenario 'can not edit modul' do
      visit course_path(course)

      expect(page).to_not have_link 'Редактировать'
    end
  end

  describe 'Authenticated user' do
    scenario 'can not edit modul', js: true do
      sign_in user
      visit course_path(course)

      expect(page).to_not have_button 'Редактировать'
    end
  end

  scenario 'Admin can edit modul', js: true do
    sign_in admin
    visit course_path(course)

    click_on 'Редактировать'

    fill_in 'modul[title]', with: 'Modul Title New'
    click_on 'Сохранить изменения'

    expect(page).to have_content 'Modul Title New'
    expect(page).to_not have_content 'ModulTitle'
  end
end
