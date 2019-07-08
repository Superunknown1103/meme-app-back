class User < ApplicationRecord
  has_many :memes, through: :votes
            # Include default devise modules.
            devise :database_authenticatable, :registerable,
                    :recoverable, :rememberable, :validatable,
                    :omniauthable
            include DeviseTokenAuth::Concerns::User
end
