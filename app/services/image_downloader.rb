# frozen_string_literal: true

require 'open-uri'

# app/services/image_downloader.rb
class ImageDownloader
  def initialize(source)
    @uri = parse_uri(source)
  end

  def save_to_tmp_storage
    open(tmp_path, 'wb') do |tmp_file|
      tmp_file << open(uri.to_s).read
    end
  end

  def filename
    uri.path.gsub('/', '_')
  end

  private

  def parse_uri(source)
    begin
      URI.parse(source)
    rescue URI::InvalidURIError
      URI.parse(URI.escape(source))
    end
  end

  def tmp_path
    "#{Rails.root}/tmp/storage/#{filename}"
  end

  attr_accessor :temporary_image_saver, :uri
end
