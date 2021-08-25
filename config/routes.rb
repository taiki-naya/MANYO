Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  namespace :admin do
    resources :users, only: [:index, :new, :create, :edit, :update, :destroy]
  end
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  get '/search', to: 'tasks#search'
end
