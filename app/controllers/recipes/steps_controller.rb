module Recipes
  class StepsController < ApplicationController
    protect_from_forgery with: :exception, except: [:create], prepend: true

    def update
      ParsedLine.where(id: parsed_lined_ids_params).update_all(deleted: true)
      Step.update(params[:id], step_params)

      render json: {success: true}
    end

    private

    def step_params
      params.permit(step: [:content, :recipe_id])[:step]
    end

    def parsed_lined_ids_params
      params.permit(parsed_line_ids: [])[:parsed_line_ids]
    end
  end
end
