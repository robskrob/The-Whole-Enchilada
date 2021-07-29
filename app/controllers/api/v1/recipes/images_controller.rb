class Api::V1::Recipes::ImagesController < ApplicationController
  protect_from_forgery with: :exception, except: [:create], prepend: true

  def create
    image_json_array = []

    if params[:imageDataArray].kind_of?(Array)
      image_json_array = JSON.parse(params[:imageDataArray].to_json)
    else
      image_json_array = JSON.parse(params[:imageDataArray])
    end

    RecipeImagesImporterWorker.perform_async(image_json_array, params[:recipe_id])

    render json: {message: 'currently importing', success: true}
  end

  private

  def recipe_params
    params.permit(:imageDataArray)
  end
end
