class WebRecipesController < ApplicationController
  protect_from_forgery with: :exception, except: [:create], prepend: true

  def create
    byebug
    web_recipe = WebRecipe.find_by_name(web_recipe_params[:name])

    if web_recipe
      message = {message: "Recipe already exists", success: false}
    else
      web_recipe = WebRecipe.create(web_recipe_params)
      recipe = Recipe.create(
        title: web_recipe.pathname.parameterize.gsub(/-/, ' ').titleize
      )
      # create parsed lines
      # ParsedLinesInserterWorker.perform_async(web_recipe.content, recipe.id, nil)

    end
    # find the web recipe if it exists
    # if it exists
      # respond to client that it exists
    # if it does not exist
      # create web recipe
      # the name of the web recipe will be a parameterized version
      # of the domain name of the site combined with the title of the recipe
      # create recipe
      # create parsed lines and or parsed long lines

    render json: {body: params.to_json}
  end

  private

  def web_recipe_params
    params.permit(:content, :host_origin, :name, :pathname)
  end
end
