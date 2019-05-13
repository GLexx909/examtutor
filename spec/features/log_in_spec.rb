require 'rails_helper'

feature 'User can log in', %q{
} do

  given(:user) { create(:user) }
  background { visit enter_page_initials_path }

  scenario 'Registered user tries to log in' do
    fill_in 'Почта', with: user.email
    fill_in 'Пароль', with: user.password
    find('.pupil-submit').click

    expect(page).to have_content 'Вход в систему выполнен.'
  end

  scenario 'Unregistered user tries to sign in' do
    fill_in 'Почта', with: 'wrong@test.com'
    fill_in 'Пароль', with: '12345678'
    find('.pupil-submit').click

    expect(page).to have_content 'Неверный Почта или пароль.'
  end
end
