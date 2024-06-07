Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'dashboard', to: 'pages#dashboard'
  resources :activities, only: [:new, :create, :index, :show] do
    resources :members, only: [:create, :update, :destroy]
  end
  # resources :members
  # Defines the root path route ("/")
  # root "posts#index"
  get 'profile', to: 'pages#profile'
end
