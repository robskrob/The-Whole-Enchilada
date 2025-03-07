class Api::V1::WebRecipesController < ApplicationController
  before_action :authenticate_user!

  protect_from_forgery with: :exception, except: [:create], prepend: true

  def create
    web_recipe = WebRecipe.find_by_name(web_recipe_params[:name])

    if web_recipe
      message = {message: "Recipe already exists", recipe: web_recipe.recipe, success: false}
    else
      web_recipe = WebRecipe.create(web_recipe_params)

      recipe = Recipe.create(
        title: web_recipe.pathname.parameterize.gsub(/-/, ' ').titleize,
        web_recipe_id: web_recipe.id,
        full_text: web_recipe.content.gsub(/(\R)(?:\s*\R)+/, '\1'),
        user_id: current_user.id
      )

      message = {message: "Recipe saved!", recipe: recipe, success: true}
    end

    render json: message.to_json
  end

  private

  def web_recipe_params
    params.permit(:content, :host_origin, :name, :pathname)
  end
end
