require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root to: 'pages#home'

  devise_for :users, skip: :all, skip_helpers: true

  devise_scope :user do
    resources :registrations, only: [:new, :create, :update, :edit]
    resources :sessions, only: [:create, :new, :destroy]
    resources :passwords, only: [:create, :new, :update]
    resources :confirmations, only: [:create, :new]
  end

  resources :recipes, only: [:create, :destroy, :edit, :index, :new, :show, :update] do
    scope module: :recipes do
      resources :images, only: [:update, :destroy]
      resources :ingredients, only: [:create, :update, :destroy]
      resources :parsed_lines, only: [:update]
      resources :steps, only: [:create, :update, :destroy]
      resources :tips, only: [:create, :update, :destroy]
      resources :tools, only: [:create, :update, :destroy]
    end
  end

  resource :account, only: [:show, :edit, :update]

  namespace :api do
    namespace :v1 do
      resources :web_recipes, only: [:create, :show]

      resources :recipes do
        scope module: :recipes do
          resources :images, only: [:create]
        end
      end
    end
  end
end
