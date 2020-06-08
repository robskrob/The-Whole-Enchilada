class RecipeBuilderPresenter

  def initialize(recipe)
    @recipe = recipe
    @steps = recipe.steps
  end

  def step_options
    options = steps.map do |step|
      number = step.position + 1
      [number.ordinalize, step.id]
    end

    if options.present?
      new_step_number = steps.order(position: :asc).last.position + 2

      options.push([new_step_number.ordinalize, ''])
    else
      ["1st", 0]
    end
  end

  private

  attr_accessor :recipe, :steps
end
