class ParsedLinesInserterWorker
  include Sidekiq::Worker

  def perform(text, recipe_id, image_id)
    # line_creator = LineCreator.new(text)
    # lines = line_creator.run
    lines = text.split("\n").inject({lines: [], long_lines: []}) do |acc, line|
      line_trimmed = line.strip

      line_attributes = {
        content: line_trimmed,
        recipe_id: recipe_id,
        image_id: image_id,
        created_at: Time.now.utc,
        updated_at: Time.now.utc
      }

      if line_trimmed.length > 500
        acc[:long_lines] << line_attributes
      else
        acc[:lines] << line_attributes
      end

      acc
    end

    if lines[:lines].present?
      ParsedLine.insert_all(lines[:lines])
    end

    if lines[:long_lines].present?
      ParsedLongLine.insert_all(lines[:long_lines])
    end
  end
end
