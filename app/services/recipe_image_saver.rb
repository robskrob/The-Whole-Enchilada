class RecipeImageSaver
  def initialize(file, recipe)
    @file = file
    @recipe = recipe
  end

  def run
    if file.present?
      image = Image.create(attachable_id: recipe.id, attachable_type: 'Recipe')

      tmp_path = "#{Rails.root}/tmp/storage/#{file.original_filename}"

      File.open("#{tmp_path}",'wb') do |f|
        f.write file.read
      end

      image.file.attach(
        io: File.open(file.path),
        filename: file.original_filename,
        content_type: file.content_type
      )
    end
  end

  private

  attr_accessor :file, :recipe
end
