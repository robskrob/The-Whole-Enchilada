class Api::V1::MeController < ApplicationController

  def index
    render json: current_user
  end
end
