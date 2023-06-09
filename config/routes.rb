Rails.application.routes.draw do
  #action cable server
  mount ActionCable.server => "/cable"

  resources :billing_statuses
  resources :statuses
  resources :tags
  resources :messages
  resources :chats
  get 'second_chats', to: 'chats#second_chats_index'
  get 'theme/test'
  devise_for :users
  resources :theme
  get 'supervisor/themes', to: 'theme#themes_from_supervisor'
  get 'supervisor/themes/:id', to: 'theme#themes_from_supervisor'
  resources :supervisor
  post '/supervisor/remove_tags', to: 'supervisor#remove_tags'
  post '/supervisor/add_tags', to: 'supervisor#add_tags'
  #get 'supervisor_from_tag', to: 'tags#supervisor'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
