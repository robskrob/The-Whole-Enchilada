require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root to: 'pages#home'

  get '/health-check', to: 'application#health'
  patch '/recipes/:recipe_id/images/:id/featured', to: 'recipes/images#featured'

  devise_for :users, skip: :all, skip_helpers: true

  devise_scope :user do
    resources :registrations, only: [:new, :create, :update, :edit]
    resources :sessions, only: [:create, :new, :destroy]
    resources :passwords, only: [:create, :new, :update]
    resources :confirmations, only: [:create, :new]
  end

  resources :web_recipes, only: [:create]

  resources :recipes, only: [:create, :destroy, :edit, :index, :new, :show, :update] do
    scope module: :recipes do
      resources :images, only: [:update, :destroy]
      resources :parsed_lines, only: [:update]
      resources :ingredients, only: [:create]
      resources :tools, only: [:create]
      resources :steps, only: [:update]
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
