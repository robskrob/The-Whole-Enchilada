module Recipes
  class IngredientsController < ApplicationController
    protect_from_forgery with: :exception, except: [:create], prepend: true

    def create
      render json: {success: true, message: 'ingredient created'}
    end
  end
end
