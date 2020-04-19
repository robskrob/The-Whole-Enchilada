require 'sidekiq/web'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  mount Sidekiq::Web => '/sidekiq'

  resources :recipes, only: [:create, :delete, :edit, :index, :new, :show, :update] do
    scope module: :recipes do
      resources :images, only: [:update]
      resources :parsed_lines, only: [:update]
    end
  end
end
