class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :meme

  validates :user_id, uniqueness: { scope: :meme_id,
  message: "vote: (meme <-> user) relationship already exists" }
end
