class AddTitleToSteps < ActiveRecord::Migration[6.0]
  def change
    add_column :steps, :title, :string, length: 250
  end
end
