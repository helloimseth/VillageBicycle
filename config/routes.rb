Rails.application.routes.draw do
  root to: 'static_pages#root'

  get "/auth/:provider/callback", to: "sessions#omniauth"

  resources :users, only: [:new] do
    collection do
       get 'activate'
    end
  end
  #
  # resources :bikes, except: [:index] do
  #   collection { get 'search' }
  # end
  #
  # resources :requests, only: [:create, :update, :delete] do
  #     member do
  #       post 'approve'
  #       post 'reject'
  #     end
  # end

  resource :sessions, only: [:new, :create, :destroy] do
    member { get 'demo_sign_in' }
  end

  namespace :api, defaults: { format: :json } do
    resources :users

    resources :bikes do
      collection { get 'search' }
    end

    resources :sets, only: [:index]

    resources :requests, only: [:show, :create, :update, :destroy]

    resources :quick_searches, only: [:index]
  end


end
