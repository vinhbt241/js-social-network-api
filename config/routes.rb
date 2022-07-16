Rails.application.routes.draw do
  namespace :api do 
    resources :users, only: [:show]
    resources :posts, only: [:show]
  end
end
