require 'sidekiq/web'

Rails.application.routes.draw do
  resources :events
  mount Sidekiq::Web => '/sidekiq' if Rails.env.development?

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  post '/calender_callback/:id', to: 'calender_callback#create'

  root 'home#index'
end
