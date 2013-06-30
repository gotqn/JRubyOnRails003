class SessionsController < ApplicationController

  skip_before_filter :is_profile_complete

  def new
  end

  def create
    @security_user = SecurityUser.find_by_email(params[:session][:email])
    @status = 'success'
    if @security_user && @security_user.advanced_authentication(params[:session][:password])
      if @security_user.is_active
        if params[:session][:keep_me_login] then
          cookies.permanent[:auth_token] = @security_user.auth_token
        else
          cookies[:auth_token] = @security_user.auth_token
        end
        respond_to do |format|
          format.html { redirect_to webinars_path, notice: 'Logged in!'}
          format.js { @status }
        end
      else
        @status = 'not_active'
        respond_to do |format|
          format.html { redirect_to webinars_path, notice: 'Account not activated!'}
          format.js { @status }
        end
      end
    else
      @status = 'failed'
      respond_to do |format|
        format.html { redirect_to webinars_path, notice: 'Email or password is invalid!'}
        format.js { @status }
      end
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to webinars_path, notice: 'Logged out!'
  end
end
