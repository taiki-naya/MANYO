Rails.application.routes.draw do
  root 'tasks#index'
  resources :users, only: [:new, :create]
  resources :tasks
  get '/search', to: 'tasks#search'
end
