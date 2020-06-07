class AccountsController < ApplicationController
  def show
    @recipes = current_user.recipes
  end
end
