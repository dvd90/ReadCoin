Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :kids, only: [:index, :show, :new, :create, :edit, :update] do
    resources :purchases, only: [:index, :create]
    resources :readings, only: [:index, :create]
    resources :books, only: [:index, :show]
  end
  resources :prizes, only: [:index, :show]
  get 'login', to: 'kids#login', as: :kids_login
end
