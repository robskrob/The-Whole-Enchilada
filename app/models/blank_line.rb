class BlankLine
  def initialize(image_id, recipe_id, text)
    @image_id = image_id
    @recipe_id = recipe_id
    @text = text
  end

  def create
    {
      content: text.to_s.strip,
      recipe_id: recipe_id,
      image_id: image_id,
      created_at: Time.now.utc,
      updated_at: Time.now.utc
    }
  end

  def can_create?
    true
  end

  def is_long?
    false
  end

  def is_standard_length?
    false
  end

  def valid?
    false
  end

  private

  attr_accessor :image_id, :recipe_id, :text

end
