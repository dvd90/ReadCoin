Rails.application.routes.draw do
  root "pages#home"

  # Parent authentication (Rails 8 built-in)
  resource :session
  resources :passwords, param: :token
  resource :registration, only: %i[new create]

  # Parent area
  namespace :family do
    root "dashboards#show"
    resources :kids
    resources :rewards, except: :show
    resources :redemptions, only: %i[index update]
    resources :books do
      resource :quiz, only: %i[edit update] do
        post :generate
      end
    end
  end

  # Kid area — PIN login, no parent credentials needed on the device
  scope module: :play, path: "play", as: :play do
    root "sessions#new"
    post "family", to: "sessions#pick_family", as: :pick_family
    get  "kids/:id/pin", to: "sessions#pin", as: :pin
    post "kids/:id/session", to: "sessions#create", as: :session
    delete "session", to: "sessions#destroy", as: :logout

    get "dashboard", to: "dashboards#show", as: :dashboard
    resources :books, only: %i[index show] do
      member do
        post :start
        get  :read
        get  :quiz
        post :quiz, action: :submit_quiz, as: :submit_quiz
      end
    end
    get  "shop", to: "shop#index", as: :shop
    post "shop/:reward_id", to: "shop#redeem", as: :redeem
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
