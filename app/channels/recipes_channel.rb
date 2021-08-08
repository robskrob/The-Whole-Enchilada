class RecipesChannel < ApplicationCable::Channel
  def subscribed
    recipe = Recipe.includes(:images).find(params[:id])

    stream_for recipe
    recipe.images.each do |image|

      transmit({
        recipe_id: image.attachable_id,
        image_id: image.id,
        alt_text: image.alt_text,
        url: image.file.service_url
      }.to_json)
    end
  end

  def receive(data)

  end

  def appear(data)
    RecipesChannel.broadcast_to(image.attachable, data)
  end
end
