Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :profiles, only: [:new, :create, :edit, :update]
  resources :events do
    resources :participations, only: [:create, :update]
    resources :chatrooms, only: [:show] do
      resources :messages, only: [:create]
    end
  end

  root "events#index"
  get "/explore", to: "events#index", as: :explore
  get "/dashboard", to: "users#dashboard", as: :dashboard
end
