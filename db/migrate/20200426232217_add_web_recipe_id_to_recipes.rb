class AddWebRecipeIdToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_reference :recipes, :web_recipes, foreign_key: true, index: true
  end
end
