require 'rails_helper'

feature 'User can sign out', %q{
} do

  given(:user) { create(:user) }
  background { visit root_path }

  scenario 'Registered user tries to sign out' do
    fill_in 'Почта', with: user.email
    fill_in 'Пароль', with: user.password
    click_on 'Log in'

    click_on 'Sign out'

    expect(page).to have_content 'Выход из системы выполнен.'
  end
end