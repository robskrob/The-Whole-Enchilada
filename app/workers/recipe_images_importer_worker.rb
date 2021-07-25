# frozen_string_literal: true

# app/workers/recipe_images_importer_worker.rb
class RecipeImagesImporterWorker
  include Sidekiq::Worker

  def perform(image_data_array, recipe_id)
    if recipe_id.present?
      image_data_array.each do |image_data|
        RecipeImageSaverWorker.perform_async(
          image_data['alt'],
          recipe_id,
          image_data['source']
        )
      end
    end
  end
end
