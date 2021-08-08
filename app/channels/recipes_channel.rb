class RecipesChannel < ApplicationCable::Channel
  def subscribed
    recipe = Recipe.find(params[:id])

    stream_for recipe
  end

  def receive(data)

  end

  def appear(data)
    RecipesChannel.broadcast_to(image.attachable, data)
  end
end
