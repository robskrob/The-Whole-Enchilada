class AddAltTextToImages < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :alt_text, :string, length: 250
  end
end
