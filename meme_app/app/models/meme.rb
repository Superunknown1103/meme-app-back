class Meme < ApplicationRecord
    has_many :users, through: :votes
    has_one_attached :link
end
