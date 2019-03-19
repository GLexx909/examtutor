require 'rails_helper'

feature 'User can see profiles list', %q{
} do

  given(:user) { create(:user) }
  given(:users) { create_list(:user, 3) }
  given(:admin) { create(:user, admin: true, first_name: 'Admin') }

  scenario 'User can see profiles list' do
    sign_in(user)
    visit profiles_path

    users.each do |user|
      expect(page).to have_content user.first_name
    end
  end

  scenario 'User can not see admin in profiles list' do
    sign_in(user)
    visit profiles_path

    users.each do |user|
      expect(page).to_not have_content admin.first_name
    end
  end
end
