class ImageRecipeInserter
  include ActionView::Helpers::TextHelper

  def initialize(alt_text, filename, recipe)
    @alt_text = alt_text.to_s
    @filename = filename.to_s
    @recipe = recipe
  end

  def associate_and_insert
    image = recipe.images.create(alt_text: valid_alt_text_length)

    image.file.attach(
      io: File.open(tmp_path),
      filename: filename
    )
  end

  private

  def valid_alt_text_length
    if alt_text.to_s.length > Image::ALT_TEXT_CHAR_LIMIT
      truncate(alt_text, length: 250)
    else
      alt_text
    end
  end

  def tmp_path
    "#{Rails.root}/tmp/storage/#{filename}"
  end

  attr_accessor :alt_text, :filename, :recipe

end
