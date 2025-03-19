Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  get "/dashboard", to: "pages#dashboard", as: :dashboard

  authenticated do
    resources :profiles, only: [:show, :new, :create, :edit, :update]
    resources :events do
      resources :participations, only: [:create, :update]
      resources :chatrooms, only: [:show] do
        resources :messages, only: [:create]
      end
    end
    root "events#index", as: :authenticated_root
  end

  root "pages#home"
end
