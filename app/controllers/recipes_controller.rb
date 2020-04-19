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
    recipe_updater = RecipeUpdater.new({
      recipe_id: params[:id],
      recipe: {
        published_at: params[:recipe][:date_published],
        description: params[:recipe][:description],
        title: params[:recipe][:title]
      },
      recipe_asset: params[:recipe][:images][:file],
      recipe_image_saver: RecipeImageSaver,
      recipe_attributes_saver: RecipeAttributesSaver
    })

    @recipe = recipe_updater.coordinate

    redirect_to @recipe
  end
end
