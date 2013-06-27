class SecurityUserMailer < ActionMailer::Base

  add_template_helper(EmailConfirmationHelper)

  default from: 'tuvarna.system.message@gmail.com'

  def password_reset(security_user)
    @security_user = security_user
    mail to: security_user.email, subject: 'Password Reset'
  end

  def email_confirmation(security_user)
    @security_user = security_user
    mail to: security_user.email, subject: 'Account Created'
  end

end
