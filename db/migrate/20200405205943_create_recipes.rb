class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :title, length: 150, null: false
      t.text :description
      t.datetime :published_at

      t.timestamps
    end
  end
end
