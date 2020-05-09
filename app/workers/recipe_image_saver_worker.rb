class RecipeImageSaverWorker
  include Sidekiq::Worker

  def perform(alt_text, recipe_id, source)
    image_recipe_importer = ImageRecipeImporter.new(alt_text, recipe_id, source, {
      image_downloader_factory: ImageDownloader,
      image_recipe_inserter_factory: ImageRecipeInserter,
    })

    image_recipe_importer.coordinate
  end
end
