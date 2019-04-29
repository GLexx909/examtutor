require 'rails_helper'

feature 'Only admin can edit tutor info', %q{
} do

  given!(:admin) { create(:user, admin: true) }
  given!(:tutor_info) {create(:tutor_info, description: 'DescriptionOfTutor') }

  describe "Unauthenticated user" do
    scenario 'can not see edit button' do
      visit tutor_infos_path

      expect(page).to_not have_button 'Редактировать описание'
    end
  end

  describe 'Admin' do
    scenario 'edit tutor info', js: true do
      sign_in admin
      visit tutor_infos_path

      click_on 'Редактировать описание'

      tinymce_fill_in('tutor_info_description', 'DescriptionNew')
      click_on 'Сохранить'
      sleep 2
      expect(page).to have_content 'DescriptionNew'
      expect(page).to_not have_content 'DescriptionOfTutor'
    end

    scenario 'edit tutor info with attach files', js: true do
      sign_in admin
      visit tutor_infos_path

      click_on 'Редактировать описание'

      attach_file 'tutor_info_initial_profile_photo', "#{Rails.root}/spec/rails_helper.rb"

      click_on 'Сохранить'
    end
  end
end
