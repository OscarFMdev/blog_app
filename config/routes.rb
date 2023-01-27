Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html 
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:new, :create]
    end
  end
  resources :posts, only: [:new, :create]

  root "users#index"
  # Defines the root path route ("/")
  # root "articles#index"
end
