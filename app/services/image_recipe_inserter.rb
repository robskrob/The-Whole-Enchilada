# frozen_string_literal: true

# app/services/image_recipe_inserter.rb
class ImageRecipeInserter
  include ActionView::Helpers::TextHelper

  def initialize(alt_text, filename, recipe)
    @alt_text = alt_text.to_s
    @filename = filename.to_s
    @recipe = recipe
  end

  def associate_and_insert
    ActiveStorage::Attachment.after_create_commit do
      image = Image.includes(:attachable).find(self.record_id)

      RecipesChannel.broadcast_to(image.attachable, {
        recipe_id: image.attachable_id,
        image_id: image.id,
        alt_text: image.alt_text,
        url: self.service_url
      })
    end

    create_image.file.attach(
      io: File.open(tmp_path),
      filename: filename
    )
  end

  private

  def create_image
    Image.create(
      alt_text: valid_alt_text_length,
      attachable_id: recipe.id,
      attachable_type: 'Recipe',
      featured: recipe.images.blank?
    )
  end

  def valid_alt_text_length
    if alt_text.to_s.length > Image::ALT_TEXT_CHAR_LIMIT
      truncate(alt_text, length: Image::ALT_TEXT_CHAR_LIMIT)
    else
      alt_text
    end
  end

  def tmp_path
    "#{Rails.root}/tmp/storage/#{filename}"
  end

  attr_accessor :alt_text, :filename, :recipe
end
