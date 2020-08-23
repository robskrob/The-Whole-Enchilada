class StepCreate
  def initialize(id, attributes, options = {})
    @id = id
    @attributes = attributes
    @step_model_constant = options[:step_model_constant]
    @step_image_saver_constant = options[:step_image_saver_constant]
  end

  def can_save?
    attributes.keys == ["content", "recipe_id"] &&
      attributes.values.length == 2
  end

  def last_position_value
    step_model_constant
      .where(recipe_id: attributes["recipe_id"])
      .order(:position)
      .last
      .position
  end

  def save
    step_model_constant.create(
      content: attributes[:content],
      position: last_position_value + 1,
      recipe_id: attributes[:recipe_id],
      title: attributes[:title]
    )
  end

  private

  attr_accessor :id, :attributes, :step_model_constant
end
