Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :kids, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    get 'create_avatar', to: 'kids#create_avatar', as: :create_avatar
    # post 'add_RDC', to: 'kids#add_RDC', as: :add_RDC
    resources :books, only: [:index, :show] do
      get 'quiz', to: 'books#quiz', as: :quiz
      post 'check_quiz', to: 'books#check_quiz', as: :check_quiz
      get 'answers_quiz/:score', to: 'books#answers_quiz', as: :answers_quiz
      resources :readings, only: [:index, :create, :show]
      get 'reader', to: 'readings#reader', as: :reader
    end
    resources :prizes, only: [:index, :show] do
      resources :purchases, only: [:index, :create, :show]
    end
  end

  namespace :admin do
    resources :books
    resources :prizes
  end

  resources :orders, only: [:show, :create] do
    resources :payments, only: [:new, :create]
  end

  get 'login', to: 'kids#login', as: :kids_login
  post 'login', to: 'kids#create_login', as: :verify_password
  get 'kid_dashboard/:id', to: 'kids#kid_dashboard', as: :kid_dashboard
end
