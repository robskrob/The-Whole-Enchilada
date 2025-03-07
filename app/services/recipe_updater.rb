class RecipeUpdater
  def initialize(options = {})
    @recipe = options[:recipe]
    @recipe_attributes = options[:recipe_attr]
    @recipe_asset = assign_asset(options[:recipe_asset])
    @recipe_image_saver_factory = options[:recipe_image_saver]
    @recipe_attributes_saver_factory = options[:recipe_attributes_saver]
  end

  def coordinate
    recipe_image_saver = recipe_image_saver_factory.new(recipe_asset, recipe)
    recipe_image_saver.run

    recipe_attribute_saver = recipe_attributes_saver_factory.new(recipe, recipe_attributes)
    recipe_attribute_saver.run

    recipe
  end

  private

  def assign_asset(asset)
    if asset
      asset[:file]
    else
      {}
    end
  end

  attr_accessor :recipe_asset, :recipe, :recipe_attributes,
    :recipe_image_saver_factory, :recipe_attributes_saver_factory
end
