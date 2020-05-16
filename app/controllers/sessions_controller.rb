class SessionsController < Devise::SessionsController
  def new
    render :new
  end

  def create
    if user_signed_in?
      byebug
      redirect_to root_path

    else
      byebug
    end
  end
end
