class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.boolean :text_processed, default: false
      t.references :recipe, index: true, foreign_key: true

      t.timestamps
    end
  end
end
