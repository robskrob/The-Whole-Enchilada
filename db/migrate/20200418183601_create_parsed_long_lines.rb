class CreateParsedLongLines < ActiveRecord::Migration[6.0]
  def change
    create_table :parsed_long_lines do |t|
      t.text :content, null: false
      t.references :recipe, index: true, foreign_key: true
      t.references :image, index: true, foreign_key: true

      t.timestamps
    end
  end
end
