class ImageTextParserWorker
  include Sidekiq::Worker

  def perform(image_id)
    image = Image.find(image_id)

    if image.present?
      parser = ImageParser.new(image)

      text = parser.generate_text

      existing_text = image.attachable.full_text.to_s

      updated = existing_text + text

      # this updates recipe full text
      image.attachable.update(full_text: updated)
    end
  end
end
