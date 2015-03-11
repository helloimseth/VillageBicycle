Rails.application.routes.draw do
  resources :users, except: [:index] do
    collection { get 'activate' }
  end

  resources :bikes, except: [:index] do
    collection { get 'search' }
  end

  resource :sessions, only: [:new, :create, :destroy]
end
