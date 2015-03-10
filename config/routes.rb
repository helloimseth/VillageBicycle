Rails.application.routes.draw do
  resources :users, except: [:index]
end
