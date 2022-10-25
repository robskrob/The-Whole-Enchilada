class SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token

  def respond_with(resource, *)
    if current_user.present?
      redirect_to recipes_path
    end
  end

end
