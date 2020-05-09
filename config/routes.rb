require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :recipes, only: [:create, :delete, :edit, :index, :new, :show, :update] do
    scope module: :recipes do
      resources :images, only: [:update]
      resources :parsed_lines, only: [:update]
      resources :ingredients, only: [:create]
      resources :tools, only: [:create]
      resources :steps, only: [:update]
    end
  end

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
