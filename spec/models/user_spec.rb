require 'rails_helper'

def create_user(username = 'testuser', email = 'testuser@example.com', password = 'password')
  User.create(username: username, email: email, password: password)
end

describe User, type: :model do
  it 'validates a normal user' do
    user = create_user 'user', 'mail', 'password'
    expect(user).to be_valid
  end

  it 'validates username and email uniqueness' do
    user = create_user 'user', 'mail', 'password'
    expect(user).to be_valid

    wrong_username = create_user 'user', 'mail2', 'password2'
    wrong_email = create_user 'user2', 'mail', 'password3'

    expect(wrong_username).not_to be_valid
    expect(wrong_email).not_to be_valid
  end
end
