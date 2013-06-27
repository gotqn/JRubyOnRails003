class ApplicationController < ActionController::Base

  protect_from_forgery

  #before_filter :is_profile_complete

  helper_method :current_user

  private

    def current_user
       # in case user is logged in but his account is deleted
       begin
         @current_user ||= SecurityUser.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
       rescue ActiveRecord::RecordNotFound
         cookies.delete(:auth_token)
         redirect_to webinars_path, notice: 'Logged out!'
       end
    end

    def is_profile_complete
      if current_user
        @security_users_detail = SecurityUsersDetail.find_by_security_user_id(current_user.id)
        unless current_user.is_profile_completed
           if @security_users_detail.nil?
             @security_users_detail = current_user.build_security_users_detail(security_users_detail: SecurityUsersDetail.new)
           end
           redirect_to edit_security_users_detail_path(@security_users_detail)
        end
      end
    end

end
