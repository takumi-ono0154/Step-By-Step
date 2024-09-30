Rails.application.routes.draw do
  root "static_pages#top"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  devise_scope :user do
    get "guest_sign_in", to: "users/sessions#guest_sign_in", as: :guest_sign_in
  end

  get "users/:id", to: "users#show", as: "user"

  resources :habits, only: [ :index, :new, :create, :destroy ]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
