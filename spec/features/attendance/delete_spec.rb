require 'rails_helper'

feature 'Admin only can delete user attendance', %q{
} do

  given!(:user) {create(:user, first_name: 'Boris') }
  given!(:admin) {create(:user, admin: true) }
  given!(:characteristic) {create(:characteristic, user: user) }
  given!(:attendance) {create(:attendance, user: user) }

  # describe 'Admin' do
  #   background do
  #     sign_in(admin)
  #     visit characteristic_path(user)
  #   end
  #
  #   scenario 'delete an attendance', js: true do
  #
  #     within '.attendance-list' do
  #       find(".attend-#{attendance.id}").click
  #       click_on('Удалить')
  #     end
  #
  #     expect(page).to have_content 'Посещение успешно удалено!'
  #   end
  # end

  scenario 'User can not delete attendance' do
    sign_in(user)
    visit characteristic_path(user)

    expect(page).to_not have_button "Удалить"
  end
end
