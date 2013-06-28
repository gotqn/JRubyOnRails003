class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :is_profile_complete

  helper_method :current_user

  private

    # checking if user is logged in
    def current_user

       begin
         @current_user ||= SecurityUser.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
       rescue ActiveRecord::RecordNotFound # in case user is logged in but his account is deleted
         cookies.delete(:auth_token)
         redirect_to webinars_path, notice: 'Logged out!'
       end
    end

    # checking if user profile is completed
    def is_profile_complete
      if current_user
        @security_users_detail = SecurityUsersDetail.find_by_security_user_id(current_user.id)
        unless current_user.is_profile_completed
          if @security_users_detail.nil?
            current_user.set_default_relations
          end
          redirect_to edit_security_users_detail_path(SecurityUsersDetail.find_by_security_user_id(current_user.id))
        end
      end
    end

end
