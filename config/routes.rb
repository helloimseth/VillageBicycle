Rails.application.routes.draw do
  resources :users, except: [:index]
  resource :sessions, only: [:new, :create, :destroy]
end
