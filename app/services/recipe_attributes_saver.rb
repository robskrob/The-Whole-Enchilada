class RecipeAttributesSaver
  def initialize(recipe, attributes = {})
    @recipe = recipe
    @attributes = attributes
  end

  def run
    recipe.update(attributes)
    recipe
  end

  private

  attr_accessor :attributes, :recipe
end
