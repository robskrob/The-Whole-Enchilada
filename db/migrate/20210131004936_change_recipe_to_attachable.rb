class ChangeRecipeToAttachable < ActiveRecord::Migration[6.0]
  def change
    rename_column :images, :recipe_id, :attachable_id

    unless column_exists? :images, :attachable_type
      add_column :images, :attachable_type, :string
    end
  end
end
