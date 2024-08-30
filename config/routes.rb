Rails.application.routes.draw do
  root "static_pages#top"
  devise_for :users
  resources :habits do
    collection do
      post "confirm"
    end
  end
end
