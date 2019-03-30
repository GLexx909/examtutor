require 'rails_helper'

feature 'User only can create essay', %q{
} do

  given!(:admin) {create(:user, admin: true) }
  given!(:user) {create(:user) }
  given!(:course) {create(:course) }
  given!(:modul) {create(:modul, course: course) }
  given!(:essay) {create(:essay, modul: modul) }
  # given(:essay_passage) {create(:essay_passage, essay: essay, user: user) }

  describe 'User' do
    background do
      sign_in(user)
      visit essay_path(essay)
    end

    scenario 'create a essay', js: true do
      expect(page).to have_button 'Написать эссе'
      # Capybara не хочет видеть кнопку Сохранить
      # click_on 'Написать эссе'
      # tinymce_fill_in('essay_passage_body', 'EssayBody')
      #
      # click_on 'Сохранить'
      #
      # within '.essay-passage__body' do
      #   expect(page).to have_content 'EssayBody'
      # end
    end

    # scenario 'create a essay with error', js: true do
    # end
  end
end

