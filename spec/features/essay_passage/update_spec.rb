require 'rails_helper'

feature 'User only can update essay', %q{
} do

  given!(:admin) {create(:user, admin: true) }
  given!(:user) {create(:user) }
  given!(:admin) {create(:user, admin: true) }
  given!(:course) {create(:course) }
  given!(:modul) {create(:modul, course: course) }
  given!(:essay) {create(:essay, modul: modul) }
  given!(:essay_passage) {create(:essay_passage, essay: essay, user: user) }

  describe 'User' do
    background do
      sign_in(user)
      visit essay_path(essay)
    end

    scenario 'create a essay', js: true do
      click_on 'Редактировать эссе'
      tinymce_fill_in('essay_passage_body', 'EssayBodyNew')

      click_on 'Сохранить'

      within '.essay-passage__body' do
        expect(page).to have_content 'EssayBodyNew'
      end
    end

    scenario 'create a essay with error', js: true do
      click_on 'Редактировать эссе'
      tinymce_fill_in('essay_passage_body', '')

      click_on 'Сохранить'

      expect(page).to have_content 'Эссе не может быть пустым'
    end
  end
end

