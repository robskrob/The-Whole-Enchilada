class CustomAuthenticationFailure < Devise::FailureApp
  def respond
    invalid_log_in =  warden_options[:message].to_s == 'invalid' && warden_options[:action].to_s == "unauthenticated"
    unconfirmed_account = warden_options[:message].to_s == 'unconfirmed' && warden_options[:action].to_s == "unauthenticated"
    not_found = warden_options[:message].to_s == 'not_found_in_database' && warden_options[:action].to_s == "unauthenticated"

    if invalid_log_in
      flash[:alert] = i18n_message
      redirect_to new_session_path
    elsif unconfirmed_account
      flash[:alert] = i18n_message + " Please check your email."
      redirect_to new_session_path
    elsif not_found
      flash[:alert] = "Invalid Email or password."
      redirect_to new_session_path
    end
  end
end
