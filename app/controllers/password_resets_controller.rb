class PasswordResetsController < ApplicationController

  def new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    security_user = SecurityUser.find_by_email(params[:password_resets][:email])
    security_user.send_password_reset if security_user
    respond_to do |format|
      @notice = 'Email sent with password reset instructions'
      format.html { redirect_to webinars_path, notice: @notice  }
      format.js { @notice }
    end
  end

  def edit
    @security_user = SecurityUser.find_by_password_reset_token(params[:id])
    if @security_user
    else
       @header = 'User not found.'
       @content = 'Your password reset token is invalid.'
       render template: 'shared/system_message',
              locals: { header: @header, content: @content}
    end
  end

  def update
    @security_user = SecurityUser.find_by_password_reset_token!(params[:id])
    if @security_user.password_reset_sent_at < 2.hours.ago
      respond_to do |format|
        format.html { redirect_to new_password_reset_path, notice: 'Password reset has expired.'}
        format.js {}
      end
    elsif  @security_user.update_attributes(params[:security_user])
      respond_to do |format|
        format.html { redirect_to webinars_path, notice: 'Password has been changed.'}
        format.js {}
      end
    else
      respond_to do |format|
        format.html { render :edit}
        format.js {}
      end
    end
  end

end
