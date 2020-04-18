class Line
  def initialize(text)
    @text = text
  end

  def valid?
    trimmed  = text.to_s.strip
    trimmed.present? && trimmed.length <= 500
  end

  def create
    {
      content: line_trimmed,
      recipe_id: recipe_id,
      image_id: image_id,
      created_at: Time.now.utc,
      updated_at: Time.now.utc
    }
  end

  private

  attr_accessor :text

end
