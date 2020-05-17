class PasswordsController < Devise::PasswordsController
  def new
    @user = User.new
  end

  def create

    self.resource = resource_class.send_reset_password_instructions(resource_params)

    if successfully_sent?(resource)
      message = I18n.t('devise.passwords.send_instructions')
      redirect_to root_path, flash: { notice: message }
    else
      redirect_to new_password_path, flash: {error: resource.errors.full_messages.join(', ')}
    end
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)

    if resource.errors.empty?
      if Devise.sign_in_after_reset_password
        resource.after_database_authentication
        sign_in(resource_name, resource)
      end

      message = I18n.t('devise.passwords.updated')
      redirect_to root_path, flash: { notice: message }
    else
      user = User.find(params[:id])
      user.reset_password_token = resource.reset_password_token
      error = resource.errors.full_messages.join(', ')

      redirect_to root_path, flash: { error: message }
    end
  end
end
