require 'rails_helper'

feature 'User can sign up', %q{
} do

  given!(:one_time_password) { create(:one_time_password) }

  scenario 'Unregistered user tries to sign up with correct one_time_password' do
    visit root_path

    click_on 'Вход для ученика'
    click_on 'Зарегистироваться'

    fill_in 'preregistration_pass', with: 123
    click_on 'Confirm'

    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'

    find_button('Sign up').click
    expect(page).to have_content 'В течение нескольких минут вы получите письмо с инструкциями по подтверждению вашей учётной записи.'

    open_email('user@test.com')
    current_email.click_link 'Confirm my account'

    expect(page).to have_content 'Ваша учётная запись успешно подтверждена.'
  end

  scenario 'Unregistered user tries to sign up with incorrect one_time_password' do
    visit root_path

    click_on 'Вход для ученика'
    click_on 'Зарегистироваться'

    fill_in 'preregistration_pass', with: 'incorrect'
    click_on 'Confirm'

    expect(page).to have_content 'Доступ закрыт'
  end
end
