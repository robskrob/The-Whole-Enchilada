class SessionsController < Devise::SessionsController

  def respond_with(resource, *)
    if user_signed_in?
      redirect_to recipes_path
    end
  end

end
