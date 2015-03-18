Rails.application.routes.draw do
  root to: 'static_pages#root'

  resources :users, except: [:index] do
    collection { get 'activate' }
  end

  resources :bikes, except: [:index] do
    collection { get 'search' }
  end

  resources :requests, only: [:create, :update, :delete] do
      member do
        post 'approve'
        post 'reject'
      end
  end

  resource :sessions, only: [:new, :create, :destroy]

  namespace :api, defaults: { format: :json } do
    resources :users

    resources :bikes do
      collection { get 'search' }
    end

    resources :sets, only: [:index]

    resources :requests, only: [:show, :create, :update, :delete]

    resources :quick_searches, only: [:index]
  end

end
