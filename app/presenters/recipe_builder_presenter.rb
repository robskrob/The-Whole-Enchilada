class RecipeBuilderPresenter

  attr_accessor :steps

  def initialize(recipe)
    @recipe = recipe
    @steps = recipe.steps.order(position: :asc)
  end

  def step_options
    options = steps.map do |step|
      number = step.position + 1
      [number.ordinalize, step.id]
    end

    if options.present?
      new_step_number = steps.last.position + 2

      options.push([new_step_number.ordinalize, ''])
    else
      ["1st", 0]
    end
  end

  private

  attr_accessor :recipe
end
