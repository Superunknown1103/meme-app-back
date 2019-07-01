class User < ApplicationRecord
    has_many :memes, through :votes
end
