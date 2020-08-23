class StepOne
  def initialize(id, attributes, options = {})
    @id = id
    @attributes = attributes
    @step_model_constant = options[:step_model_constant]
    @step_image_saver_constant = options[:step_image_saver_constant]
  end

  def can_save?
    id == 0
  end

  def save
    step_instance = step_model_constant.new({
      content: attributes[:content],
      position: 0,
      recipe_id: attributes[:recipe_id],
      title: attributes[:title]
    })

    step_instance.save
  end

  private

  attr_accessor :id, :attributes, :step_model_constant
end
