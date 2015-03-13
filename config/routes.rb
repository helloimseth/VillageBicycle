Rails.application.routes.draw do
  root to: 'users#show'

  resources :users, except: [:index] do
    collection { get 'activate' }
  end

  resources :bikes, except: [:index] do
    collection { get 'search' }
  end

  resources :requests, only: [:create, :update, :delete]

  resource :sessions, only: [:new, :create, :destroy]
end
