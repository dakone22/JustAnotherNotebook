class Note < ApplicationRecord
  belongs_to :user, optional: true
  validates_presence_of :content

  def anonymous?
    user.nil?
  end
end
