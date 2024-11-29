Rails.application.routes.draw do
  devise_for :users
  root "videos#index"

  resources :videos do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create]
    resources :watch_counts, only: [:create]
    # resources :watch_counts, only: [:show]
  end
  resources :videos do
    resource :like, only: [:create, :destroy]
  end
  
end
