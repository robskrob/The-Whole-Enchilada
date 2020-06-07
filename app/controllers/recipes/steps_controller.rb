module Recipes
  class StepsController < ApplicationController
    protect_from_forgery with: :exception, except: [:create], prepend: true

    def update
      updater = StepUpdater.new({
        id: params[:id],
        attributes: step_params,
        parsed_line_model_constant: ParsedLine,
        parsed_line_ids: parsed_line_ids_params,
        step_model_constant: Step,
        step_saver_factories: [StepOne, StepUpdate, StepCreate]
      })

      updater.run

      render json: {success: true}
    end

    private

    def step_params
      params.permit(step: [:content, :recipe_id])[:step]
    end

    def parsed_line_ids_params
      params.permit(parsed_line_ids: [])[:parsed_line_ids]
    end
  end
end
