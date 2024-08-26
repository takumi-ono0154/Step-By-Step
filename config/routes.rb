Rails.application.routes.draw do
  resources :habits do
    collection do
      post 'confirm'
    end
  end
  resources :users
  root "static_pages#top"
end
