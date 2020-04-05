class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.create(
      title: params[:recipe][:title],
      description: params[:recipe][:description]
    )

    redirect_to @recipe
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
