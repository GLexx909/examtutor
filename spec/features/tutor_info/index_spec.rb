require 'rails_helper'

feature 'Guests can see tutor info', %q{
} do

  given!(:tutor_info) {create(:tutor_info, description: 'DescriptionOfTutor') }

  describe 'Unauthorised user' do
    background do
      visit tutor_infos_path
    end

    scenario 'can see description', js: true do
      expect(page).to have_content "DescriptionOfTutor"
    end

    scenario 'can no see edit button', js: true do
      expect(page).to_not have_button "Редактировать описание"
    end
  end
end
