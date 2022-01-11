Rails.application.routes.draw do
  namespace :admin do
    get 'users/new'
    get 'users/edit'
    get 'users/show'
    get 'users/index'
  end
  root to: 'tasks#index'
  resources :tasks do
    collection do
      get :search
    end
  end
end
