Rails.application.routes.draw do
  root "static_pages#top"
  get "terms", to: "static_pages#terms"
  get "privacy", to: "static_pages#privacy"

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "omniauth_callbacks"
  }

  devise_scope :user do
    get "guest_sign_in", to: "users/sessions#guest_sign_in", as: :guest_sign_in
  end

  get "users/:id", to: "users#show", as: "user"

  resources :habits, only: [ :index, :new, :create, :destroy ] do
    resources :completions, only: [ :create ]
  end

  post "line/webhook", to: "line#webhook"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
