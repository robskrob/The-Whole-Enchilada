class AddPositionToSteps < ActiveRecord::Migration[6.0]
  def change
    add_column :steps, :position, :integer
  end
end
