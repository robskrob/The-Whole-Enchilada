class StepUpdate
  def initialize(id, attributes, step_model_constant = Step)
    @id = id
    @attributes = attributes
    @step_model_constant = step_model_constant
  end

  def can_save?
    instance = step_model_constant.find_by_id(id)

    byebug
    if instance.present?
      step_instance = instance
      true
    else
      false
    end
  end

  def save
    if step_instance.present?
      step_instance.update(attributes)
    else
      step_model_constant.update(id, attributes)
    end
  end

  private

  attr_accessor :id, :attributes, :step_instance, :step_model_constant
end
