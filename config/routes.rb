Rails.application.routes.draw do
  root "recipes#index"

  # 用户注册和登录路由
  get "signup", to: "users#new"
  resources :users, except: [ :index, :destroy ]

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # 食谱路由，包括嵌套的食材和步骤
  resources :recipes do
    resources :ingredients, only: [ :create, :update, :destroy ]
    resources :steps, only: [ :create, :update, :destroy ]

    # 收藏功能
    member do
      post "favorite"
      delete "unfavorite"
    end
  end

  # 收藏路由
  get "favorites", to: "users#favorites"

  # API路由
  namespace :api do
    namespace :v1 do
      devise_for :users,
                path: "",
                path_names: {
                  sign_in: "login",
                  sign_out: "logout",
                  registration: "signup"
                },
                controllers: {
                  sessions: "api/v1/sessions",
                  registrations: "api/v1/registrations"
                }

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
