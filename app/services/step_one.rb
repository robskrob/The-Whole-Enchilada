class StepOne
  def initialize(id, attributes, step_model_constant = Step)
    @id = id
    @attributes = attributes
    @step_model_constant = step_model_constant
  end

  def can_save?
    byebug
    id == 0
  end

  def save
    step_instance = step_model_constant.new({
      content: attributes[:content],
      position: 0,
      recipe_id: attributes[:recipe_id]
    })

    step_instance.save
  end

  private

  attr_accessor :id, :attributes, :step_model_constant
end
