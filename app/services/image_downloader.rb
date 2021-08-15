# frozen_string_literal: true

require 'open-uri'

# app/services/image_downloader.rb
class ImageDownloader
  def initialize(source)
    @uri = parse_uri(source)
  end

  def save_to_tmp_storage
    open(tmp_path, 'wb') do |tmp_file|
      tmp_file << open(clean_url).read
    end
  end

  def filename
    uri.path.gsub('/', '_')
  end

  private

  def clean_url
    "http://#{uri.host}#{uri.path}"
  end

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
