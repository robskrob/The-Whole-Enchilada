class LongLine
  def initialize(image_id, recipe_id, text)
    @image_id = image_id
    @recipe_id = recipe_id
    @text = text
  end

  def can_create?
    valid?
  end

  def create
    {
      content: text.strip,
      recipe_id: recipe_id,
      image_id: image_id,
      created_at: Time.now.utc,
      updated_at: Time.now.utc
    }
  end

  def is_long?
    true
  end

  def is_standard_length?
    false
  end

  def valid?
    trimmed  = text.to_s.strip
    trimmed.present? && trimmed.length > 500
  end

  private

  attr_accessor :image_id, :recipe_id, :text

end
