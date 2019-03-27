require 'rails_helper'

feature 'Admin only can edit essay', %q{
} do

  given!(:user) { create(:user) }
  given!(:admin) { create(:user, admin: true) }
  given!(:course) { create :course }
  given!(:modul) { create :modul, course: course  }
  given!(:essay) { create :essay, modul: modul, title: 'EssayTitle'  }

  describe "Unauthenticated user" do
    scenario 'can not edit essay' do
      visit essay_path(essay)

      expect(page).to_not have_link 'Редактировать'
    end
  end

  describe 'Authenticated user' do
    scenario 'can not edit essay', js: true do
      sign_in user
      visit essay_path(essay)

      expect(page).to_not have_button 'Редактировать'
    end
  end

  scenario 'Admin can edit essay', js: true do
    sign_in admin
    visit essay_path(essay)

    click_on 'Редактировать'

    fill_in 'essay[title]', with: 'Essay Title New'
    click_on 'Сохранить изменения'

    expect(page).to have_content 'Essay Title New'
    expect(page).to_not have_content 'EssayTitle'
  end
end
