Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users

  root "users#index"

  resources :users do
    resources :posts
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
