Rails.application.routes.draw do
  resources :users
  root "static_pages#top"
end
