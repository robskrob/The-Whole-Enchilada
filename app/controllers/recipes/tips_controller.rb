module Recipes
  class TipsController < ApplicationController
    protect_from_forgery with: :exception, except: [:create], prepend: true

    def create
      ParsedLine.where(id: parsed_lined_ids_params).update_all(deleted: true)
      Tip.create(content: tip_params["tip"]["content"], recipe_id: params["recipe_id"])

      render json: {success: true}
    end

    def destroy
      tip = Tip.find(params[:id])
      tip.update(deleted: true)

      redirect_to edit_recipe_path(params[:recipe_id])
    end

    def update
      tip = Tip.find(params[:id])

      if tip
        tip.update(content: tip_params[:tip][:content])

        redirect_to edit_recipe_path(params[:recipe_id])
      else
        redirect_to edit_recipe_path(params[:recipe_id])
      end
    end

    private

    def tip_params
      params.permit(tip: [:content])
    end

    def tips_params
      params.permit(tips: [:content, :recipe_id])[:tips]
    end

    def parsed_lined_ids_params
      params.permit(parsed_line_ids: [])[:parsed_line_ids]
    end
  end
end
