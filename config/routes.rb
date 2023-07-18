require 'devise_token_auth'

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'authentications', skip: [:omniauth_callbacks]
      resources :movies, only: [:index, :show]
      resources :movie_showtimes, except: [:new, :edit]
      resources :user_movie_ratings, only: [:create, :update]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
