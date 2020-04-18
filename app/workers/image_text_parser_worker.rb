class ImageTextParserWorker
  include Sidekiq::Worker

  def perform(image_id)
    image = Image.find(image_id)
    parser = ImageParser.new(image)

    text = parser.generate_text

    ParsedLinesInserterWorker.perform_async(text, image.recipe_id, image.id)
  end
end
