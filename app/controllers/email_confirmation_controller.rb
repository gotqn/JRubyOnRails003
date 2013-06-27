class EmailConfirmationController < ApplicationController

  def update
    @security_user = SecurityUser.find_by_id(params[:security_user_id])

    if @security_user
      if @security_user.is_active
        render template: 'email_confirmation/status.html.erb',
               locals: { notice: 'Your account has been already activated!' }
      else
        if @security_user.activation_code == params[:activation_code]
          if @security_user.change_user_status(true)
            render template: 'email_confirmation/status.html.erb',
                   locals: { notice: 'Congratulations!Activation is successful.' }
          else
            render template: 'email_confirmation/status.html.erb',
                   locals: { notice: 'Internal Error' }
          end
        else
          render template: 'email_confirmation/status.html.erb',
                 locals: { notice: 'Activation failed - wrong activation code!' }
        end
      end
    else
      render template: 'email_confirmation/status.html.erb',
             locals: { notice: 'User not found.' }
    end
  end

end
