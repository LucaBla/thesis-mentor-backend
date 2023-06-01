Rails.application.routes.draw do
  resources :billing_statuses
  resources :statuses
  resources :tags
  resources :messages
  resources :chats
  get 'theme/test'
  devise_for :users
  resources :theme
  resources :supervisor
  post '/supervisor/remove_tags', to: 'supervisor#remove_tags'
  post '/supervisor/add_tags', to: 'supervisor#add_tags'
  #get 'supervisor_from_tag', to: 'tags#supervisor'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
