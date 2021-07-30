require 'open-uri'

class RecipesController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, :except => [:index, :show]

  def create

    url_validator = UrlValidator.new(params[:web_recipe][:url])

    if url_validator.valid?
      uri = url_validator.value

      html_response_body_string = Net::HTTP.get_response(uri).body

      parser = HtmlPageParser.new(
        html_response_body_string,
        Nokogiri::HTML(html_response_body_string)
      )


      name = uri.path + uri.host

      web_recipe = WebRecipe.find_by_name(name)

      @image_sources = parser.query_image_sources

      if web_recipe
        redirect_to edit_recipe_path(web_recipe.recipe, web_recipe_url: params[:web_recipe][:url])
      else

        new_web_recipe = WebRecipe.create({
          content: parser.inner_text,
          host_origin: uri.host,
          name: name,
          pathname: uri.path
        })

        @recipe = Recipe.create(
          title: new_web_recipe.pathname.parameterize.gsub(/-/, ' ').titleize,
          web_recipe_id: new_web_recipe.id,
          full_text: new_web_recipe.content.gsub(/(\R)(?:\s*\R)+/, '\1'),
          user_id: current_user.id
        )

        redirect_to edit_recipe_path(@recipe, web_recipe_url: params[:web_recipe][:url])
      end
    else
      redirect_to new_recipe_path, flash: { error: 'Invalid URL' }
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])

    url_validator = [
      UrlValidator.new(params[:web_recipe_url]),
      UrlValidator.new(
        "https://#{@recipe.web_recipe.host_origin}#{@recipe.web_recipe.pathname}"
      )
    ].find(&:valid?)



    if url_validator
      html_response_body_string = Net::HTTP.get_response(url_validator.value).body

      parser = HtmlPageParser.new(
        html_response_body_string,
        Nokogiri::HTML(html_response_body_string)
      )

      @image_sources = parser.query_image_sources
    end

    @text = []
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect_to recipes_path
  end

  def index
    @pagy, @recipes = pagy(
      Recipe.includes(:images).merge(
        Image.with_attached_file
      ).all.order(created_at: :desc)
    )

    if params[:search]
      @searched = Recipe.search(params[:search], page: params[:page], per_page: 20)
      @pagy_search = Pagy.new_from_searchkick(@searched)

    else
      @searched = []
    end
  end

  def new
    @recipe = WebRecipe.new
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def update
    recipe_updater = RecipeUpdater.new({
      recipe_id: params[:id],
      recipe: {
        published_at: params[:recipe][:date_published],
        description: params[:recipe][:description],
        full_text: params[:recipe][:full_text],
        title: params[:recipe][:title]
      },
      recipe_asset: params[:recipe][:images],
      recipe_image_saver: RecipeImageSaver,
      recipe_attributes_saver: RecipeAttributesSaver
    })

    recipe = recipe_updater.coordinate

    redirect_to edit_recipe_path(recipe.id)
  end

end
