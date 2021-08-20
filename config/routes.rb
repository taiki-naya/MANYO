Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  get '/search', to: 'tasks#search'
end
