class RecipesController < ApplicationController
  def create
    @recipe = Recipe.new(
      title: params[:recipe][:title],
      description: params[:recipe][:description]
    )

    @recipe.save

    if params[:recipe][:images].present? && params[:recipe][:images][:file].present?
      image = @recipe.images.create
      file = params[:recipe][:images][:file]

      image.file.attach(
        io: File.open(file.path),
        filename: file.original_filename,
        content_type: file.content_type
      )
    end

    redirect_to @recipe
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @text = []
  end

  def new
    @recipe = Recipe.new
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    image = @recipe.images.create
    file = params[:recipe][:images][:file]

    image.file.attach(
      io: File.open(file.path),
      filename: file.original_filename,
      content_type: file.content_type
    )

    redirect_to @recipe
  end
end
