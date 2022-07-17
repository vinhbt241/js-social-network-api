Rails.application.routes.draw do
  namespace :api do 
    resources :users, only: [:show]
    resources :posts, only: [:show]

    get '/users/:user_id/friends', to: 'users#friends'
  end
end
