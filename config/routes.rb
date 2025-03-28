Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  get "/dashboard", to: "pages#dashboard", as: :dashboard

  authenticated do
    resources :profiles, only: [:show, :new, :create, :edit, :update]
    resources :events do
      resources :participations, only: [:create, :update, :destroy]
      resources :chatrooms, only: [:show] do
        resources :messages, only: [:create]
      end
    end
    root "events#index", as: :authenticated_root
  end
  patch "participations/:id/accepted", to: "participations#accepted", as: :accept_participation
  patch "participations/:id", to: "participations#rejected", as: :reject_participation
  patch "participations/:id/delete", to: "participations#destroy", as: :cancel_participation

  root "pages#home"
end
