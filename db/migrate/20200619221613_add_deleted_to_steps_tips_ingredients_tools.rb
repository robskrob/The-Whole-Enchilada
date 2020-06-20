class AddDeletedToStepsTipsIngredientsTools < ActiveRecord::Migration[6.0]
  def change
    add_column :ingredients, :deleted, :boolean, default: false
    add_column :steps, :deleted, :boolean, default: false
    add_column :tips, :deleted, :boolean, default: false
    add_column :tools, :deleted, :boolean, default: false
  end
end
