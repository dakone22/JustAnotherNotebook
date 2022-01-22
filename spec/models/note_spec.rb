require 'rails_helper'

describe Note, type: :model do
  it 'validates a normal note' do
    expect(Note.new(content: 'test')).to be_valid
  end

  it 'does not validates empty note' do
    expect(Note.new).not_to be_valid
  end
end
