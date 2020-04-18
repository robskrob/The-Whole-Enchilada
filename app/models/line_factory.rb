class LineFactory
  def initialize(line_text, options = {})
    @line_text = line_text

    @line_instances = [
      Line.new(options[:image_id], options[:recipe_id], line_text),
      LongLine.new(options[:image_id], options[:recipe_id], line_text),
      BlankLine.new(options[:image_id], options[:recipe_id], line_text)
    ]
  end

  def init
    line_instances.find { |line| line.can_create? }
  end

  private

  attr_accessor :line_text, :line_instances

end
