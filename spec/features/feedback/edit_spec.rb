require 'rails_helper'

feature 'User can edit feedback', %q{
} do

  given!(:user) {create(:user) }
  given!(:feedback) {create(:feedback, user: user, body: 'FeedbackBody') }

  describe 'Authenticate user' do
    background do
      sign_in(user)
      visit feedbacks_path
    end

    scenario 'edit an feedback', js: true do
      within '.feedbacks-list' do
        click_on 'Редактировать'
        fill_in 'feedback[body]', with: 'FeedbackBodyNew'

        click_on 'Создать'

        expect(page).to have_content 'FeedbackBodyNew'
      end
    end

    scenario 'edit an feedback with error', js: true do
      within '.feedbacks-list' do
        click_on 'Редактировать'
        fill_in 'feedback[body]', with: ''

        click_on 'Создать'

        expect(page).to have_content 'FeedbackBody'
      end

      expect(page).to have_content 'Отзыв не может быть пустым'
    end
  end

  scenario 'Unauthenticated user tries to edit an feedback' do
    visit feedbacks_path
    expect(page).to_not have_button('Оставить отзыв')
  end
end
