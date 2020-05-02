class AddWebRecipeIdToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_reference :recipes, :web_recipe, foreign_key: true, index: true
  end
end
