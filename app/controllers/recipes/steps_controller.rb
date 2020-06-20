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

    def create
      creator = StepCreate.new(
        params[:id],
        step_params,
        Step
      )

      creator.save

      ParsedLine
        .where(id: parsed_line_ids_params)
        .update_all(deleted: true)

      render json: {success: true}
    end

    def destroy
      step = Step.find(params[:id])
      step.update(deleted: true)

      redirect_to edit_recipe_path(params[:recipe_id])
    end

    private

    def step_params
      params.permit(step: [:content, :recipe_id, :title])[:step]
    end

    def parsed_line_ids_params
      params.permit(parsed_line_ids: [])[:parsed_line_ids]
    end
  end
end
