Rails.application.routes.draw do
  get '/users/activate'
  resources :users, except: [:index] do
    resources :bikes, only: [:new, :index]
  end

  resources :bikes, except: [:new, :index]

  resource :sessions, only: [:new, :create, :destroy]
end
