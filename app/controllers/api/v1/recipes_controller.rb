class Api::V1::RecipesController < ApplicationController
  protect_from_forgery with: :exception, except: [:update], prepend: true

  def update
    byebug
#    recipe_image_saver = RecipeImageSaver.new(recipe_asset, recipe)
#    recipe_image_saver.run
  end

  private

  def recipe_params
    params.permit(:content, :host_origin, :name, :pathname)
  end
end
