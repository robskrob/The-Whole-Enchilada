module Recipes
  class TipsController < ApplicationController
    protect_from_forgery with: :exception, except: [:create], prepend: true

    def create
      tips = tips_params.map do |tip|
        {
          content: tip[:content],
          recipe_id: tip[:recipe_id],
          created_at: Time.now.utc,
          updated_at: Time.now.utc
        }
      end

      ParsedLine.where(id: parsed_lined_ids_params).update_all(deleted: true)
      Tip.insert_all(tips)

      render json: {success: true}
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
