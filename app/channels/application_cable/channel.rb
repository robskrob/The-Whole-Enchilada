module ApplicationCable
  class Channel < ActionCable::Channel::Base
    identified_by :current_user

    def connect
      if current_user.present?
        self.current_user = current_user
      else
        self.current_user = reject_unauthorized_connection
      end
    end
  end
end
