class LineCreator
  def initialize(text, options = {})
    @line_factory = options[:line_factory]
    @lines_factory = options[:lines_factory]
    @image_id = options[:image_id]
    @recipe_id = options[:recipe_id]
    @text = text
  end

  def run
    lines = text.split("\n").inject({standard: [], long: []}) do |acc, line|
      line_model = line_factory.new(
        line, {
          image_id: image_id,
          recipe_id: recipe_id
        }
      ).init

      if line_model.valid? && line_model.is_standard_length?
        line_attributes = line_model.create

        acc[:standard] << line_attributes
      end

      if line_model.valid? && line_model.is_long?
        line_attributes = line_model.create

        acc[:long] << line_attributes
      end

      acc
    end

    lines_factory.new(lines)
  end

  private

  attr_accessor :image_id, :line_factory, :lines_factory, :recipe_id, :text
end
