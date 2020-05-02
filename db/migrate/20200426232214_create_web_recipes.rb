class CreateWebRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :web_recipes do |t|
      t.string :name, length: 250, null: false
      t.string :pathname, length: 500, null: false
      t.text :content
      t.text :host_origin

      t.timestamps
    end
  end
end
