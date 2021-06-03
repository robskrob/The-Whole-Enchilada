# frozen_string_literal: true

# app/services/recipe_image_saver.rb
class RecipeImageSaver
  def initialize(file, recipe)
    @file = file
    @recipe = recipe
  end

  def run
    if file.present?
      File.open(tmp_path.to_s,'wb') do |f|
        f.write file.read
      end

      create_image.file.attach(
        io: File.open(file.path),
        filename: file.original_filename,
        content_type: file.content_type
      )
    end
  end

  private

  def create_image
    if recipe.images.length
      Image.create(attachable_id: recipe.id, attachable_type: 'Recipe')
    else
      Image.create(
        attachable_id: recipe.id,
        attachable_type: 'Recipe',
        featured: true
      )
    end
  end

  def tmp_path
    "#{Rails.root}/tmp/storage/#{file.original_filename}"
  end

  attr_accessor :file, :recipe
end
