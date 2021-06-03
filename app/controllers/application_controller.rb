class ApplicationController < ActionController::Base
  def health
    render json: {
      success: 200,
      message: 'up and running...'
    }
  end
end
