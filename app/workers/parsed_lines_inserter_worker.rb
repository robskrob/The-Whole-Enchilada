class ParsedLinesInserterWorker
  include Sidekiq::Worker

  def perform(text, recipe_id, options = {})

    if text.present? && recipe_id.present?
      line_creator = LineCreator.new(
        text, {
          line_factory: LineFactory,
          lines_factory: Lines,
          image_id: options[:image_id],
          recipe_id: recipe_id
        }
      )

      lines = line_creator.run

      if lines.standard.present?
        ParsedLine.insert_all(lines.standard)
      end

      if lines.long.present?
        ParsedLongLine.insert_all(lines.long)
      end
    end
  end
end
