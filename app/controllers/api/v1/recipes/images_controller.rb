class Api::V1::Recipes::ImagesController < ApplicationController
  protect_from_forgery with: :exception, except: [:create], prepend: true

  def create
    if params[:imageDataArray].kind_of?(Array)
      RecipeImagesImporterWorker.perform_async(JSON.parse(params[:imageDataArray].to_json), params[:recipe_id])
    else
      RecipeImagesImporterWorker.perform_async(JSON.parse(params[:imageDataArray]), params[:recipe_id])
    end

    render json: {message: 'currently importing', success: true}
  end

  private

  def recipe_params
    params.permit(:imageDataArray)
  end
end
