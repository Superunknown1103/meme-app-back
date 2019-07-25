class User < ApplicationRecord
  has_secure_password
  has_many :memes, through: :votes

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "only allows valid emails" }
end
