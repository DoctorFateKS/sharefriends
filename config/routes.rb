Rails.application.routes.draw do
  get 'users/dashboard'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :profiles, only: [:new, :create, :edit, :update]
  resources :events do
    resources :participations, only: [:create, :update]
    resources :chatrooms, only: [:show] do
      resources :messages, only: [:create]
    end
  end

  root "events#index"
  get "/home", to: "home#index", as: :home
  get "/explore", to: "events#index", as: :explore
  get "/dashboard", to: "users#dashboard", as: :dashboard
end
