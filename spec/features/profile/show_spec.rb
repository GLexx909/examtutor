require 'rails_helper'

feature 'User can see profile of user', %q{
  User can see self profile
  Or profile another user
  But not Admin profile
} do

  given(:user) { create(:user) }
  given(:user_other) { create(:user) }
  given(:admin) { create(:user, admin: true, first_name: 'Admin', last_name: 'Admin') }

  scenario 'User can see other user profile' do
    sign_in(user)
    visit profile_path(user_other)

    expect(page).to have_content user_other.full_name
  end

  scenario 'User can not see admin profile' do
    sign_in(user)
    visit profile_path(admin)

    expect(page).to_not have_content admin.full_name
  end

  scenario 'Guest can not see user profile' do
    visit profile_path(admin)

    expect(page).to_not have_content user.full_name
  end
end
