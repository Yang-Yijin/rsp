Rails.application.routes.draw do
  root "recipes#index"


  get "signup", to: "users#new"
  resources :users, except: [ :index, :destroy ]

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :recipes do
    resources :ingredients, only: [ :create, :update, :destroy ]
    resources :steps, only: [ :create, :update, :destroy ]

    member do
      post "favorite"
      delete "unfavorite"
    end
  end

  get "favorites", to: "users#favorites"

  # API
  namespace :api do
    namespace :v1 do
      post "auth", to: "registrations#create"
      post "auth/sign_in", to: "sessions#create"
      delete "auth/sign_out", to: "sessions#destroy"

      resources :recipes, only: [ :index, :show, :create, :update, :destroy ] do
        member do
          post "favorite", to: "favorites#create"
          delete "unfavorite", to: "favorites#destroy"
        end
      end

      resources :favorites, only: [ :index ]
      resources :users, only: [ :show ]
    end
  end
end
