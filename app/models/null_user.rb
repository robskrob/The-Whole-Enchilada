class NullUser

  def id
    0
  end

  def present?
    false
  end

  def valid_reset_password_link?
    false
  end
end
