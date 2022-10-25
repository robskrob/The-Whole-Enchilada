class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token, :only => :create

  def new
    render :new
  end

  def respond_with(resource, *)
    if resource.persisted?
      if resource.active_for_authentication?
        flash[:notice] = "You're signed in!"
        redirect_to root_path
      else
        flash[:alert] = resource.errors.full_messages
        redirect_to root_path
      end
    else
      flash[:error] = resource.errors.full_messages.join(' ')
      render :new
    end
  end
end
