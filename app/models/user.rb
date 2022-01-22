class User < ApplicationRecord
  has_secure_password
  has_many :notes
  validates_presence_of :username, :email, :password_digest
  validates_uniqueness_of :username, :email
  validates :password, confirmation: { case_sensitive: true }

  def can_view(note)
    note.public || note.user_id == id # || admin
  end

  def can_edit(note)
    note.user_id == id # || admin
  end
end
