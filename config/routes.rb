Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  namespace :admin do
    resources :users
  end
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  root to: 'tasks#index'
  resources :tasks do
    collection do
      get :search
    end
  end
end
