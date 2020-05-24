class CustomAuthenticationFailure < Devise::FailureApp
  def respond
    invalid_log_in = warden_options[:action].to_s == "unauthenticated" && warden_options[:message].to_s == 'invalid'
    unconfirmed_account = warden_options[:action].to_s == "unauthenticated" &&  warden_options[:message].to_s == 'unconfirmed'

    if invalid_log_in
      flash[:alert] = i18n_message
      redirect_to new_session_path
    elsif unconfirmed_account
      flash[:alert] = i18n_message + " Please check your email."
      redirect_to new_session_path
    end
  end
end
