# frozen_string_literal: true

require 'open-uri'

class UrlValidator
  def initialize(string)
    @string = string.to_s
  end

  def valid?
    uri = URI.parse(string)

    self.url = uri

    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  end

  def value
    url || string
  end

  private

  attr_accessor :string, :url
end
