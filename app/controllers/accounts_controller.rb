class AccountsController < ApplicationController
  before_action :authenticate_user!

  def show
    @recipes = current_user.recipes
  end
end
