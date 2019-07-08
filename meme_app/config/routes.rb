Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api do
    namespace :v1 do
      resources :users
      resources :memes
      post '/memes/upvote/:id', to: 'memes#increase_vote', as: 'meme_upvote'
    end
  end

  root to: 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
