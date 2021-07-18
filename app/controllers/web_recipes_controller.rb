# frozen_string_literal: true

# app/controllers/web_recipes_controller.rb

require 'open-uri'

class WebRecipesController < ApplicationController

  def create

    # url = "https://cooking.nytimes.com/recipes/1022285-sweet-and-sour-pork?module=Recipe+of+The+Day&pgType=homepage&action=click"
    # doc = Nokogiri::HTML(open(url))
    # doc.css('script, link').each { |node| node.remove }
    # puts doc.css('body').text.squeeze(" \n")

    uri = URI(url)

    html_response_string = Net::HTTP.get_response(uri)

    recipe_text = HtmlPageParser.new(html_response_string).inner_text

    WebRecipe.create({
      content: recipe_text,
      host_origin: uri.host,
      name: uri.path + uri.host,
      pathname: uri.path
    })




  end
end
