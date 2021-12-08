# frozen_string_literal: true

# app/services/html_page_parser.rb

class HtmlPageParser
  include ActionView::Helpers::SanitizeHelper

  def initialize(html_body_string, document = '')
    @html_body_string = html_body_string
    @document = document
  end

  def inner_text
    strip_tags(html_body_string)
  end

  def query_image_sources
    document.search("[style*='background-image'], img").map do |image_element|
      if image_element.name == 'img'
        image_element.attr('src')
      else
        style = image_element.attr('style')
        if style.is_a? String
          style[/url\(["']?([^"']*)["']?\)/, 1]
        else
          style.value[/url\(["']?([^"']*)["']?\)/, 1]
        end
      end
    end
  end

  private

  attr_accessor :document, :html_body_string
end
