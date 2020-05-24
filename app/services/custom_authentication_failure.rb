class CustomAuthenticationFailure < Devise::FailureApp
  def respond
    if warden_options[:action].to_s == "unauthenticated" && i18n_message == "Invalid Email or password."
      flash[:alert] = i18n_message
      redirect_to new_session_path
    end
  end
end
