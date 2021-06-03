# frozen_string_literal: true

# app/services/image_recipe_downloader.rb
class ImageRecipeImporter
  def initialize(alt_text, recipe_id, source, factory_options = {})
    @alt_text = alt_text
    @recipe_id = recipe_id
    @source = source
    @image_downloader_factory = factory_options[:image_downloader_factory]
    @image_recipe_inserter_factory = factory_options[:image_recipe_inserter_factory]
  end

  def coordinate
    image_downloader = image_downloader_factory.new(
      source
    )

    image_downloader.save_to_tmp_storage

    image_recipe_inserter = image_recipe_inserter_factory.new(
      alt_text,
      image_downloader.filename,
      Recipe.find(recipe_id)
    )

    image_recipe_inserter.associate_and_insert
  end

  private

  attr_accessor :alt_text, :recipe_id, :source, :image_downloader_factory, :image_recipe_inserter_factory
end
