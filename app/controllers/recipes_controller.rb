class RecipesController < ApplicationController
  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(
      title: params[:recipe][:title],
      description: params[:recipe][:description]
    )

    @recipe.save

    # blog post on how to avoid multiple inserts
    # and how to add multiple file attachments
    # per image insert
    # but in this instance I may have to tolerate
    # multiple inserts.

#    params[:recipe][:images][:file].map do |image|
#      image = @recipe.images.new
#
#      image.save
#
#      image.file.attach(
#        io: File.open(image.path),
#        filename: image.original_filename,
#        content_type: image.content_type
#      )
#    end

#    images = params[:recipe][:images].map do |image|
#    end


    if params[:recipe][:images].present? && params[:recipe][:images][:file].present?
      image = @recipe.images.create
      file = params[:recipe][:images][:file]

      image.file.attach(
        io: File.open(file.path),
        filename: file.original_filename,
        content_type: file.content_type
      )
    end

#    @stub_recipe = Recipe.find(4)
    redirect_to @recipe
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
