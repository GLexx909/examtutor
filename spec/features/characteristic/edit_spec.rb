require 'rails_helper'

feature 'Admin can update description', %q{
} do

  given!(:user) {create(:user) }
  given!(:admin) {create(:user, admin: true) }
  given!(:post) {create(:post, author: user) }
  given!(:characteristic) {create(:characteristic, user: user, description: "Description") }

  describe 'Admin' do
    background do
      sign_in(admin)
      visit characteristic_path(user)
    end

    scenario 'update the characteristic', js: true do
      click_on 'Редактировать общую характеристику'

      fill_in 'characteristic[description]', with: 'NewDescription'
      click_on 'Сохранить'

      expect(page).to have_content 'NewDescription'
    end
  end

  scenario 'User can not update a characteristic' do
    visit characteristic_path(user)
    expect(page).to_not have_button('Редактировать общую характуристику')
  end
end
