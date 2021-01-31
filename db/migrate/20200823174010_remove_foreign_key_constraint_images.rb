class RemoveForeignKeyConstraintImages < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :images, :recipes if foreign_key_exists?(:images, :recipes)
  end
end
