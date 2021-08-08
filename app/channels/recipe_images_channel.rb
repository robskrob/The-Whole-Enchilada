class RecipeImagesChannel < ApplicationCable::Channel
  def subscribed
    recipe = Recipe.find(params[:id])

    stream_for recipe
  end
end
