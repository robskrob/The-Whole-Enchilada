# frozen_string_literal: true

# app/services/html_page_parser.rb

class HtmlPageParser
  include ActionView::Helpers::SanitizeHelper

  def initialize(html_body_string)
    @html_body_string = html_body_string
  end

  def inner_text
    strip_tags(html_body_string)
  end

  private

  attr_accessor :html_body_string
end
