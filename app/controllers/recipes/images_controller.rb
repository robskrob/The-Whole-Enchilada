module Recipes
  class ImagesController < ApplicationController
    def update
      ImageTextParserWorker.perform_async(params[:id])

      redirect_to edit_recipe_path(params[:recipe_id])
    end

    def featured
      recipe = Recipe.find(params[:recipe_id])
      recipe.images.update_all(featured: false)

      image = Image.find(params[:id])
      image.update(featured: true)

      redirect_to edit_recipe_path(params[:recipe_id])
    end

    def destroy
      image = Image.find(params[:id])

      if image.present?
        image.destroy
      end

      redirect_to edit_recipe_path(params[:recipe_id])
    end
  end
end
