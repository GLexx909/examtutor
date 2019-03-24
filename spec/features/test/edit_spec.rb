require 'rails_helper'

feature 'Admin only can edit test', %q{
} do

  given!(:user) { create(:user) }
  given!(:admin) { create(:user, admin: true) }
  given!(:course) { create :course }
  given!(:modul) { create :modul, course: course  }
  given!(:test) { create :test, modul: modul, title: 'TestTitle'  }

  describe "Unauthenticated user" do
    scenario 'can not edit test' do
      visit test_path(test)

      expect(page).to_not have_link 'Редактировать'
    end
  end

  describe 'Authenticated user' do
    scenario 'can not edit test', js: true do
      sign_in user
      visit test_path(test)

      expect(page).to_not have_button 'Редактировать'
    end
  end

  scenario 'Admin can edit test', js: true do
    sign_in admin
    visit test_path(test)

    click_on 'Редактировать'

    fill_in 'test[title]', with: 'Test Title New'
    click_on 'Сохранить изменения'

    expect(page).to have_content 'Test Title New'
    expect(page).to_not have_content 'TestTitle'
  end
end
