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

    def destroy
      tool = Tool.find(params[:id])
      tool.update(deleted: true)

      redirect_to edit_recipe_path(params[:recipe_id])
    end

    def update
      tool = Tool.find(params[:id])

      if tool
        tool.update(content: tool_params[:tool][:content])

        redirect_to edit_recipe_path(params[:recipe_id])
      else
        redirect_to edit_recipe_path(params[:recipe_id])
      end
    end

    private

    def tool_params
      params.permit(tool: [:content])
    end

    def tools_params
      params.permit(tools: [:content, :recipe_id])[:tools]
    end

    def parsed_lined_ids_params
      params.permit(parsed_line_ids: [])[:parsed_line_ids]
    end
  end
end
