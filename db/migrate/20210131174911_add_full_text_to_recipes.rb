class AddFullTextToRecipes < ActiveRecord::Migration[6.0]
  def change
    add_column :recipes, :full_text, :text
  end
end
