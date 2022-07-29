Rails.application.routes.draw do
  namespace :api do 
    resources :users, only: [:show, :create]
    get '/users/:id/user_posts', to: 'users#user_posts'
    get '/users/:id/user_and_friends_posts', to:'users#user_and_friends_posts'
    get '/users/:id/friends', to: 'users#friends'
    get '/users/:id/pending_friends', to: 'users#pending_friends'
    get '/users/:id/potential_friends', to: 'users#potential_friends'
    post '/users/send_friend_request', to: 'users#send_friend_request'
    post '/users/accept_pending_request', to: 'users#accept_pending_request'
    post '/users/decline_friend_request', to: 'users#decline_friend_request'

    resources :posts, only: [:create]
    get '/posts/:id/comments', to:'posts#comments'
    get '/posts/:id/likes', to:'posts#likes'

    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]

    resources :sessions, only: [:create, :destroy]
  end
end
