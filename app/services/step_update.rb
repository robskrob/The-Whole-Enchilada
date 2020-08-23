class StepUpdate

  attr_accessor :step_instance

  def initialize(id, attributes, options = {})
    @id = id
    @attributes = attributes
    @step_model_constant = options[:step_model_constant]
    @step_image_saver_constant = options[:step_image_saver_constant]
  end

  def can_save?
    instance = step_model_constant.find_by_id(id)

    if instance.present?
      self.step_instance = instance
      true
    else
      false
    end
  end

  def save
    if step_instance.present?
      step_instance.update(
        content: attributes[:content],
        position: attributes[:position],
        title: attributes[:title]
      )

      image_saver = step_image_saver_constant.new(attributes[:image][:file], step_instance)
      image_saver.run
    end
  end

  private

  attr_accessor :id, :attributes, :step_model_constant, :step_image_saver_constant
end
