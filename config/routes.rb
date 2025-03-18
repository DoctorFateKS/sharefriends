Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  resources :profiles, only: [:new, :create]
  root to: "pages#home"
end
