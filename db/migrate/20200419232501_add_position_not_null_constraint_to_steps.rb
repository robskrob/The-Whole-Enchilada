class AddPositionNotNullConstraintToSteps < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:steps, :position, false)
  end
end
