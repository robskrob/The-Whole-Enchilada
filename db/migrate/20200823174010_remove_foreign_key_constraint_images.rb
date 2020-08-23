class RemoveForeignKeyConstraintImages < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :images, :recipes
  end
end
