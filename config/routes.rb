Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :kids, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    get 'create_avatar', to: 'kids#create_avatar', as: :create_avatar
    resources :books, only: [:index, :show] do
      resources :readings, only: [:index, :create, :show]
    end
    resources :prizes, only: [:index, :show] do
      resources :purchases, only: [:index, :create, :show]
    end
  end
  get 'login', to: 'kids#login', as: :kids_login
  post 'login', to: 'kids#create_login', as: :verify_password
  get 'kid_dashboard/:id', to: 'kids#kid_dashboard', as: :kid_dashboard
end
