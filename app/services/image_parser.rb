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

    # write file to temporary storage if it does NOT exist
    # so that Tesseract has an image file to parse
    if !File.exist?(tmp_path)
      open(tmp_path, 'wb') do |tmp_file|
        tmp_file << open(file.service_url).read
      end
    end

    tesseract_image = RTesseract.new(tmp_path)

    tesseract_image.to_s
  end

  private

  attr_accessor :image
end
