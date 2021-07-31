class SessionsController < Devise::SessionsController

  def respond_with(resource, *)
    if current_user.present?
      redirect_to recipes_path
    end
  end

end
