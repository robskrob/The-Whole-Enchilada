class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.find_and_assign_by_reset_password(token)
    User.with_reset_password_token(token)&.tap do |user|
      user.reset_password_token = token
    end
  end

  def valid_reset_password_link?
    reset_password_token.present?
  end
end
