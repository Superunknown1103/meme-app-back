class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :meme

  validates :user_id, uniqueness: true
end
