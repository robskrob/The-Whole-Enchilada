class CreateTools < ActiveRecord::Migration[6.0]
  def change
    create_table :tools do |t|
      t.string :content, length: 500, null: false
      t.references :recipe, index: true, foreign_key: true

      t.timestamps
    end
  end
end
