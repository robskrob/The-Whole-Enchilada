Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :recipes, only: [:create, :delete, :edit, :index, :new, :show, :update]
end
