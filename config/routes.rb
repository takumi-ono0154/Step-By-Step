Rails.application.routes.draw do
  resources :habits
  resources :users
  root "static_pages#top"
end
