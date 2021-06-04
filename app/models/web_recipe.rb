# frozen_string_literal: true

# app/models/web_recipe.rb
class WebRecipe < ApplicationRecord
  has_one :recipe

  def full_path
    "https://#{host_origin}#{pathname}"
  end
end
