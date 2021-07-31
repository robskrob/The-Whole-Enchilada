# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include UserHelper

  def health
    render json: {
      success: 200,
      message: 'up and running...'
    }
  end
end
