class AddPositionToIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :position, :integer, default: 0
  end
end
