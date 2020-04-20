module Recipes
  class ParsedLinesController < ApplicationController
    def update
      params[:type].constantize.update(params[:id], deleted: true)

      redirect_to edit_recipe_path(params[:recipe_id])
    end
  end
end
