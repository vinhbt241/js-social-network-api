Rails.application.routes.draw do
  namespace :api do 
    resources :users, only: [:show]

    get '/users/:id/user_posts', to: 'users#user_posts'
    get '/users/:id/user_and_friends_posts', to:'users#user_and_friends_posts'
    get '/users/:id/friends', to: 'users#friends'
  end
end
