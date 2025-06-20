# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Register page', type: :feature, js: true do
  before do
    visit new_user_path
  end

  it 'show header' do
    expect(page).to have_content('Rejestracja')
  end

  it 'create user' do
    fill_in 'user[name]', with: 'Test'
    fill_in 'user[email]', with: 'test@test.com'
    fill_in 'user[password]', with: 'EXAMPLE123!@#'
    fill_in 'user[password_confirmation]', with: 'EXAMPLE123!@#'
    click_button 'Zarejestruj'
    expect(page).to have_selector('div.notification', text: 'Sprawdź skrzynkę mailową, aby potwierdzić swoje konto.')
    expect(User.last.email).to eq 'test@test.com'
    expect(User.last.name).to eq 'Test'
    expect(User.last.confirmed?).to eq false
    visit confirm_users_path(token: User.last.confirmation_token)
    expect(page).to have_selector('div.notification', text: 'Twoje konto zostało potwierdzone, możesz się teraz zalogować.')
    expect(User.last.confirmed?).to eq true
    visit login_path
    fill_in 'email', with: 'test@test.com'
    fill_in 'password', with: 'EXAMPLE123!@#'
    click_button 'Zaloguj'
    expect(page).to have_selector('div.notification', text: 'Zalogowano poprawnie.')
  end
end
