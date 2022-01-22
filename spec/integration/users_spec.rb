require 'rails_helper'

USERNAME = 'testuser'.freeze
EMAIL = 'testuser@example.com'.freeze
PASSWORD = 'password'.freeze

def create_user(username = USERNAME, email = EMAIL, password = PASSWORD)
  User.create(username: username, email: email, password: password)
end

def signin(username = USERNAME, password = PASSWORD)
  visit signin_path
  fill_in 'user_username', with: username
  fill_in 'user_password', with: password
  click_on :commit
end

describe 'Account system', type: :feature do
  it 'register a user', js: true do
    visit signup_path
    fill_in 'user_username', with: USERNAME
    fill_in 'user_email', with: EMAIL
    fill_in 'user_password', with: PASSWORD
    click_on 'commit'

    expect(User.find_by(username: USERNAME)).not_to be_nil
  end

  it 'does not allow to sign in as non-existed user', js: true do
    signin
    expect(page.body).to include 'alert-danger'
  end

  it 'allows user to log in', js: true do
    create_user
    signin

    expect(page.body).to include USERNAME
  end

  it 'allows user to log out', js: true do
    create_user
    signin
    click_on 'logout'

    expect(page.body).to_not include USERNAME
  end
end
