class RecipeBuilderPresenter

  def initialize(recipe)
    @recipe = recipe
  end

  def steps
    recipe_steps = recipe.steps
    if recipe_steps.present?
      last_position_value = recipe_steps.order(:position).last.position
      recipe_steps.push(Step.new(recipe_id: recipe.id, content: '', position: last_position_value + 1, id: ''))
    else
      [OpenStruct.new(position: 0, id: 0)]
    end
  end

  private

  attr_accessor :recipe
end
