class RegistrationsController < Devise::RegistrationsController
  def new
    render :new
  end
end
