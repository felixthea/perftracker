Rails.application.routes.draw do
  root to: "home#index"
  devise_for :user, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :expectations, only: [ :index, :create ]
  resource :settings, only: [ :edit, :update ], controller: "users/settings"
  get "/onboarding", to: "users#onboarding", as: :onboarding
  patch "/onboarding", to: "users#update_timezone"

  post "/mailgun/incoming", to: "mailgun#incoming"
end
