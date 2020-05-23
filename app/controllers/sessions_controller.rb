class SessionsController < Devise::SessionsController

  def respond_with(resource, *)
    if user_signed_in?
      redirect_to root_path
    end
  end

end
