class StepCreate
  def initialize(id, attributes, step_model_constant = Step)
    @id = id
    @attributes = attributes
    @step_model_constant = step_model_constant
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
    step_model_constant.create(attributes.merge({position: last_position_value + 1}))
  end

  private

  attr_accessor :id, :attributes, :step_model_constant
end
