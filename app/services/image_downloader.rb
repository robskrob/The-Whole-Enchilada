require 'open-uri'

class ImageDownloader
  def initialize(source)
    @source = source
    @uri = URI.parse(source)
  end

  def save_to_tmp_storage
    open(tmp_path, 'wb') do |tmp_file|
      tmp_file << open(source).read
    end
  end

  def filename
    uri.path.gsub('/', '_')
  end

  private

  def tmp_path
    "#{Rails.root}/tmp/storage/#{filename}"
  end

  attr_accessor :source, :temporary_image_saver, :uri
end
