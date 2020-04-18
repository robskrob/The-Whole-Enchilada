require 'open-uri'

class ImageParser
  def initialize(image)
    @image = image
  end

  def generate_text
    file = image.file
    blob = image.blob

    file_name = blob.filename.to_param

    tmp_path = "#{Rails.root}/tmp/storage/#{file_name}"

    open(tmp_path, 'wb') do |tmp_file|
      tmp_file << open(file.service_url).read
    end

    tesseract_image = RTesseract.new(tmp_path)

    tesseract_image.to_s
  end

  private

  def file_extension(content_type)
    if content_type.strip == 'image/jpeg'
      'jpg'
    end
  end


  attr_accessor :image
end
