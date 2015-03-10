Rails.application.routes.draw do
  get '/users/activate'
  resources :users, except: [:index]
  resource :sessions, only: [:new, :create, :destroy]
end
