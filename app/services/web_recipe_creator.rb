# frozen_string_literal: true

class WebRecipeCreator
  def initialize(name, attrs = {})
    @name = name
    @attrs = attrs
  end

  def find_or_create
    web_recipe = WebRecipe.find_by_name(name)

    if web_recipe
      message = {message: "Recipe already exists", recipe: web_recipe.recipe, success: false}
    else
      web_recipe = WebRecipe.create(attrs)

      recipe = Recipe.create(
        title: web_recipe.pathname.parameterize.gsub(/-/, ' ').titleize,
        web_recipe_id: web_recipe.id,
        full_text: web_recipe.content,
        user_id: rob_id(User.find_by_email('jewell.robertp@gmail.com'))
      )

      message = {message: "Recipe saved!", recipe: recipe, success: true}
    end
  end

  private

  attr_accessor :name, :attrs

  def rob_id(user)
    if user
      user.id
    end
  end
end
