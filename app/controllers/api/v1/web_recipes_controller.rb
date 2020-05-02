class Api::V1::WebRecipesController < ApplicationController
  protect_from_forgery with: :exception, except: [:create], prepend: true

  def create
    web_recipe = WebRecipe.find_by_name(web_recipe_params[:name])

    if web_recipe
      message = {message: "Recipe already exists", success: false}
    else
      web_recipe = WebRecipe.create(web_recipe_params)

      recipe = Recipe.create(
        title: web_recipe.pathname.parameterize.gsub(/-/, ' ').titleize,
        web_recipe_id: web_recipe.id
      )

      ParsedLinesInserterWorker.perform_async(web_recipe.content, recipe.id)

      message = {message: "Recipe saved!", recipe: recipe, success: true}
    end

    render json: message.to_json
  end

  private

  def web_recipe_params
    params.permit(:content, :host_origin, :name, :pathname)
  end
end
