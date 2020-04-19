class AddDeletedToParsedLines < ActiveRecord::Migration[6.0]
  def change
    add_column :parsed_lines, :deleted, :boolean, default: false
    add_column :parsed_long_lines, :deleted, :boolean, default: false
  end
end
