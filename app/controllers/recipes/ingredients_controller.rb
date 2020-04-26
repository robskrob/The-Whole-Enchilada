module Recipes
  class IngredientsController < ApplicationController
    protect_from_forgery with: :exception, except: [:create], prepend: true

    def create
      ingredients = ingredients_params.map do |ingredient|
        {
          content: ingredient[:content],
          recipe_id: ingredient[:recipe_id],
          created_at: Time.now.utc,
          updated_at: Time.now.utc
        }
      end

      ParsedLine.where(id: parsed_lined_ids_params).update_all(deleted: true)
      Ingredient.insert_all(ingredients)

      render json: {success: true}
    end

    private

    def ingredients_params
      params.permit(ingredients: [:content, :recipe_id])[:ingredients]
    end

    def parsed_lined_ids_params
      params.permit(parsed_line_ids: [])[:parsed_line_ids]
    end
  end
end
