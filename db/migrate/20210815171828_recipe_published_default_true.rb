class RecipePublishedDefaultTrue < ActiveRecord::Migration[6.0]
  def change
    remove_column :recipes, :published_at
    add_column :recipes, :published_at, :boolean, default: true, null: false
  end
end
