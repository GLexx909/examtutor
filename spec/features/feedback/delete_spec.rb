require 'rails_helper'

feature 'User can delete feedback', %q{
} do

  given!(:user) {create(:user) }
  given!(:feedback) {create(:feedback, user: user, body: 'FeedbackBody') }

  describe 'Authenticate user' do
    background do
      sign_in(user)
      visit feedbacks_path
    end

    scenario 'delete an feedback', js: true do
      within '.feedbacks-list' do
        click_on 'Удалить'

        expect(page).to have_content 'FeedbackBody'
      end
    end
  end

  scenario 'Unauthenticated user tries to delete an feedback' do
    visit feedbacks_path
    expect(page).to_not have_button('Удалить')
  end
end
