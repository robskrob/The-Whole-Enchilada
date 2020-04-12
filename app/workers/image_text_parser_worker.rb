require 'open-uri'

class ImageTextParserWorker
  include Sidekiq::Worker

  def perform(image_id)
    image = Image.find(image_id)

    tmp_path = "#{Rails.root}/tmp/storage/name_of_file.jpg"

    open(tmp_path, 'wb') do |file|
      file << open(image.file.service_url).read
    end

    tesseract_image = RTesseract.new(tmp_path)

    text = tesseract_image.to_s

    text.split("\n").each do |line|
      # save into parsed line rows
      # potentially offload into another job(s)
    end
  end
end
