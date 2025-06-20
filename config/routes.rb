Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/edit"
  get "game/home"
  get "pages/home"
  root "pages#home"
  resources :users, only: [:new, :create] do
    collection do
      get :confirm
    end
  end
  get :online_users, to: "users#online"

  resources :plays, only: [:show, :create]

  resources :chats, only: [:show] do
    resources :messages, only: [:create, :edit, :update, :destroy]
  end

  resource :password_resets, only: [:new, :create, :edit, :update]

  get "admin", to: "admin#index"

  post "/ping", to: "presence#ping"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
