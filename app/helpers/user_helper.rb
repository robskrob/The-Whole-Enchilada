# frozen_string_literal: true
#
module UserHelper

  def devise_current_user

    @devise_current_user ||= (warden.authenticate(scope: :user) || NullUser.new)

  end

  def current_user
    if params[:user_id].blank?
      devise_current_user
    else
      @devise_current_user
    end
  end
end
