class Post < ApplicationRecord
  belongs_to :user

  validates :title, :body, presence: true
  validates :title, length: {minimum: 5, maximum: 255}
  validates :body, length: {minimum: 1, maximum: 65535}

end
