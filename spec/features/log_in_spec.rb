require 'rails_helper'

feature 'User can log in', %q{
} do

  given(:user) { create(:user) }
  background { visit root_path }

  scenario 'Registered user tries to log in' do
    # save_and_open_page
    fill_in 'Почта', with: user.email
    fill_in 'Пароль', with: user.password
    click_on 'Log in'

    expect(page).to have_content 'Вход в систему выполнен.'
  end

  scenario 'Unregistered user tries to sign in' do
    fill_in 'Почта', with: 'wrong@test.com'
    fill_in 'Пароль', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Неверный Почта или пароль.'
  end
end
