class RecipeImagesImporterWorker
  include Sidekiq::Worker

  def perform(image_data_array, recipe_id)
    byebug
    image_data_array.each do |image_data|
      RecipeImageSaverWorker.perform_async(
        image_data["alt"],
        recipe_id,
        image_data["source"]
      )
    end
  end
end
