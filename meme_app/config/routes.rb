Rails.application.routes.draw do
  resources :items
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api do
    namespace :v1 do
      resources :users
      resources :memes
      post '/memes/upvote/:id', to: 'memes#increase_vote', as: 'meme_upvote'
    end
  end

  post 'authenticate', action: :authenticate, controller: 'api/v1/authentication'
  get 'verify_auth', action: :verify_auth, controller: 'api/v1/authentication'
  get 'logout', action: :logout, controller: 'api/v1/authentication'

  root to: 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
