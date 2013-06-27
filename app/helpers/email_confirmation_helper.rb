module EmailConfirmationHelper

  def email_confirmation_path(security_user)
    "/security_users/#{security_user.id}/email_confirmation/#{security_user.activation_code}"
  end

end
