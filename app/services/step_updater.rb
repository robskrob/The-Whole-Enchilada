class StepUpdater
  def initialize(options = {})
    @attributes =  options[:attributes]
    @id =  options[:id].to_i
    @parsed_line_model_constant = options[:parsed_line_model_constant]
    @parsed_line_ids = options[:parsed_line_ids]
    @step_model_constant = options[:step_model_constant]
    @step_savers = init_factories(options[:step_saver_factories])
  end

  def init_factories(factories)
    factories.map do |factory|
      factory.new(id, attributes, step_model_constant)
    end
  end

  def run
    step_savers
      .find { |saver| saver.can_save? }
      .save

    parsed_line_model_constant
      .where(id: parsed_line_ids)
      .update_all(deleted: true)
  end

  private

  attr_accessor :attributes,
    :id,
    :parsed_line_ids,
    :parsed_line_model_constant,
    :step_model_constant,
    :step_savers

end
