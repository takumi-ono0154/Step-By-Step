Rails.application.routes.draw do
  root "static_pages#top"

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  get "users/:id", to: "users#show", as: "user"

  resources :habits, only: [ :index, :new, :create, :destroy ]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
