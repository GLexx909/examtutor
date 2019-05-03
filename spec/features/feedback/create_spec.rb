require 'rails_helper'

feature 'User can create feedback', %q{
} do

  given(:user) {create(:user) }

  describe 'Authenticate user' do
    background do
      sign_in(user)
      visit feedbacks_path
    end

    scenario 'create an feedback', js: true do
      click_on 'Оставить отзыв'

      fill_in 'feedback[body]', with: 'Feedback Body'
      click_on 'Создать'

      within '.feedbacks-list' do
        expect(page).to have_content 'Feedback Body'
      end
    end

    scenario 'create an feedback with error', js: true do
      click_on 'Оставить отзыв'
      click_on 'Создать'

      expect(page).to have_content "Отзыв не может быть пустым"
    end
  end

  scenario 'Unauthenticated user tries to create an feedback' do
    visit feedbacks_path
    expect(page).to_not have_button('Оставить отзыв')
  end
end
