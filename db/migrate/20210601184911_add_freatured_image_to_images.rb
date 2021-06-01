class AddFreaturedImageToImages < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :featured, :boolean, default: false
  end
end
