Rails.application.routes.draw do
  root to: 'artists#recap'
  get 'artists/catalog'
  # get 'artists/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
