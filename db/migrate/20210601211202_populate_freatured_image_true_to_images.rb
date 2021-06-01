class PopulateFreaturedImageTrueToImages < ActiveRecord::Migration[6.0]

  def up
    execute <<-SQL
    UPDATE images
    SET featured = true
    WHERE id IN (
      SELECT images.id
      FROM (
        SELECT images.attachable_id, MIN(images.created_at) AS created_at
        FROM images
        WHERE images.attachable_type = 'Recipe'
        GROUP BY images.attachable_id
      ) oldest_images INNER JOIN images
      ON images.attachable_id = oldest_images.attachable_id
      AND oldest_images.created_at = images.created_at
    );
    SQL
  end

  def down
  end
end
