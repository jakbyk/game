Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/edit"
  get "game/home"
  get "pages/home"
  get "pages/regulation"
  get "pages/information_on_the_processing_of_personal_data"
  get "pages/how_to_play"
  get "pages/contact"
  get "pages/ranking"
  root "pages#home"
  resources :users, only: [ :new, :create ] do
    collection do
      get :confirm
    end
    member do
      post :add_tester
      delete :remove_tester
      post :add_admin
      delete :remove_admin
    end
  end
  get :online_users, to: "users#online"

  resources :plays, only: [ :show, :create, :destroy ] do
    get "budgets_descriptions", to: "plays#budgets_descriptions"
    delete "archive", to: "plays#archive"
    patch "proceed", to: "plays#proceed"
    get "result", to: "plays#result"
    get "expenses", to: "plays#expenses"
    post "budget_change", to: "plays#create_budget_change"
    get "budget_changes", to: "plays#budget_changes"
    post "budget_vote", to: "plays#budget_vote"
    get "players", to: "plays#players"
    get "settings", to: "plays#settings"
    patch "settings", to: "plays#update_settings"
    get "how_to_play", to: "plays#how_to_play"
    post "invite_player", to: "plays#invite_player"
    post "accept_invitation", to: "plays#accept_invitation"
    get "online_users", to: "plays#online_users"
    post "make_leader", to: "plays#make_leader"
    delete "remove_player", to: "plays#remove_player"
  end

  resources :archived_plays, only: [ :index, :show ]

  resources :chats, only: [ :show ] do
    resources :messages, only: [ :create, :edit, :update, :destroy ]
  end

  resource :password_resets, only: [ :new, :create, :edit, :update ]

  resources "profiles", only: [ :show, :update ] do
    post "make_friend", to: "profiles#make_friend"
    post "accept_friend", to: "profiles#accept_friend"
    delete "decline_friend", to: "profiles#decline_friend"
  end

  resources "changes", only: [ :index, :show, :create, :new ] do
    collection do
      get :info
    end
  end

  post :send_contact, to: "contacts#create_contact"

  get "admin", to: "admins#index", as: :admin
  get "admin/users", to: "admins#users", as: :admin_users
  get "admin/users/:id", to: "admins#user", as: :admin_user
  get "admin/games", to: "admins#games", as: :admin_games
  get "admin/archived_games", to: "admins#archived_games", as: :admin_archived_games
  get "admin/settings", to: "admins#settings", as: :admin_settings
  get "admin/changes", to: "admins#changes", as: :admin_changes
  get "admin/archived_changes", to: "admins#archived_changes", as: :admin_archived_changes
  get "admin/changes/:id", to: "admins#change", as: :admin_change
  post "admin/changes/:id", to: "admins#implement_change", as: :admin_implement_change
  delete "admin/changes/:id", to: "admins#not_implement_change", as: :admin_not_implement_change
  patch "admin/update_settings", to: "admins#update_settings", as: :admin_update_settings
  get "admin/archived_contacts", to: "admins#archived_contacts", as: :admin_archived_contacts
  get "admin/contacts", to: "admins#contacts", as: :admin_contacts
  get "admin/contact/:id", to: "admins#contact", as: :admin_contact
  post "admin/contact/:id/mark_readed", to: "admins#mark_readed", as: :admin_contact_mark_readed
  post "admin/contact/:id/mark_un_readed", to: "admins#mark_un_readed", as: :admin_contact_mark_un_readed
  post "admin/contact/:id/make_response", to: "admins#make_response", as: :admin_contact_make_response

  namespace :admin do
    resources :events, only: [ :index, :edit, :update, :create, :new ]
  end

  post "/ping", to: "presence#ping"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :images, only: [ :create ]
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
