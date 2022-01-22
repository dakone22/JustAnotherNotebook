require 'rails_helper'

def create_note(title = 'test_note', content = 'test_content')
  visit new_note_path

  fill_in 'note_title', with: title
  fill_in 'note_content', with: content
  click_on 'commit'

  page.current_path
end

describe 'Note system', type: :feature do
  before(:each) do
    create_user
    signin
  end

  it 'can create note' do
    visit new_note_path

    fill_in 'note_title', with: 'test_title'
    fill_in 'note_content', with: 'test_content'
    click_on 'commit'

    expect(page.body).to include 'test_title'
    expect(page.body).to include 'test_content'
  end

  it 'can edit note', js: true do
    create_note(content: 'content1')
    expect(page.body).to include 'content1'

    click_on 'edit'
    fill_in 'note_content', with: 'content2'
    click_on 'commit'

    expect(page.body).to include 'content2'
  end

  it 'check view permissions' do
    path = create_note(content: 'secret_content')

    click_on 'logout'
    visit path
    expect(page.body).not_to include 'secret_content'
  end
end
