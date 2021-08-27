Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  get '/search', to: 'tasks#search'
  namespace :admin do
    resources :users, only: [:index, :new, :create, :edit, :update, :destroy]
  end
  get '/authority/:id', to: 'admin/users#authority'
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  get '/sessions/:id', to: 'sessions#register'
end
