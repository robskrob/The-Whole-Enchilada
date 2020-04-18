class LineCreator
  def initialize(text, line_factory)
    @text = text
    @line_factory = line_factory
  end

  def run
    text.split("\n").inject({lines: [], long_lines: []}) do |acc, line|
      line_model = line_factory.new(line)

      if line_model.valid?
      end
    end
  end

  private

  attr_accessor :line_factory, :text
end
