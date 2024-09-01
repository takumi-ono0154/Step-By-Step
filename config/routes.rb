Rails.application.routes.draw do
  root "static_pages#top"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  get 'users/:id', to: 'users#show', as: 'user'
  
  resources :habits do
    collection do
      post "confirm"
    end
  end
end
