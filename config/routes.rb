Rails.application.routes.draw do
  get '/users/activate'
  resources :users, except: [:index]

  resources :bikes, except: [:index]

  resource :sessions, only: [:new, :create, :destroy]
end
