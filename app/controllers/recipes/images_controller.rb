module Recipes
  class ImagesController < ApplicationController
    def update
      ImageTextParserWorker.perform_async(params[:id])

      redirect_to recipe_path(params[:recipe_id])
    end
  end
end
