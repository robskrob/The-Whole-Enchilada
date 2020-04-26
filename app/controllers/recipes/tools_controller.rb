module Recipes
  class ToolsController < ApplicationController
    protect_from_forgery with: :exception, except: [:create], prepend: true

    def create
      tools = tools_params.map do |tool|
        {
          content: tool[:content],
          recipe_id: tool[:recipe_id],
          created_at: Time.now.utc,
          updated_at: Time.now.utc
        }
      end

      ParsedLine.where(id: parsed_lined_ids_params).update_all(deleted: true)
      Tool.insert_all(tools)

      render json: {success: true}
    end

    private

    def tools_params
      params.permit(tools: [:content, :recipe_id])[:tools]
    end

    def parsed_lined_ids_params
      params.permit(parsed_line_ids: [])[:parsed_line_ids]
    end
  end
end
