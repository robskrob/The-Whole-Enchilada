class SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token, :only => :create

  def respond_with(resource, *)
    if current_user.present?
      redirect_to recipes_path
    end
  end

end
