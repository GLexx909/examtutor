require 'rails_helper'

feature 'Unregistered user (parent) can enter', %q{
  To see user (pupil) characteristic
} do

  given!(:user) { create(:user) }
  given!(:characteristic) { create(:characteristic, user: user) }
  background { visit root_path }

  scenario 'with valid identify' do
    fill_in 'identify_name[]', with: "#{user.last_name}-#{user.id}"
    find('.parent-submit').click

    expect(current_path).to eql(characteristic_path(user))
  end

  scenario 'with invalid identify' do
    fill_in 'identify_name[]', with: "Error_name-#{user.id}"
    find('.parent-submit').click

    expect(current_path).to eql(root_path)

    expect(page).to have_content 'Идентификатор набран неверно'
  end
end
