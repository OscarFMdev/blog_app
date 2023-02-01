Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html 
  devise_scope :user do
    get '/logout', to: 'sessions#logout', as: :logout
  end
  
  devise_for :users
  root to: "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:new, :create]
    end
  end
  resources :posts, only: [:new, :create]
  
  # Defines the root path route ("/")
  # root "articles#index"
end