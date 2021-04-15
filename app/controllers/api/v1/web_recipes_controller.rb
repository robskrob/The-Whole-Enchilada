class Api::V1::WebRecipesController < ApplicationController
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
        full_text: web_recipe.content,
        user_id: rob_id(User.find_by_email('jewell.robertp@gmail.com'))
      )

      message = {message: "Recipe saved!", recipe: recipe, success: true}
    end

    render json: message.to_json
  end

  private

  # DELETE THIS once we have user authentication from chrome
  # extension tool
  def rob_id(user)
    if user
      user.id
    end
  end

  def web_recipe_params
    params.permit(:content, :host_origin, :name, :pathname)
  end
end
