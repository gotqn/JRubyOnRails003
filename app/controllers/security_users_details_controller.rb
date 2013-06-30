class SecurityUsersDetailsController < ApplicationController

  skip_before_filter :is_profile_complete, only: [:edit, :update]

  # GET /security_users_details/1
  # GET /security_users_details/1.json
  def show
    @security_users_detail = SecurityUsersDetail.find(params[:id])

    if current_user.id == @security_users_detail.security_user_id
      @current_title_text = 'My Profile'
    else
      @current_title_text = 'Profile of ' + @security_users_detail.first_name + ' ' + @security_users_detail.last_name
    end

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render json: @security_users_detail }
    end
  end

  # GET /security_users_details/1/edit
  def edit

    @security_users_detail = SecurityUsersDetail.find(params[:id])

    if current_user.id == @security_users_detail.security_user_id
      @current_title_text = 'Edit Profile'
    else
      @current_title_text = 'Edit Profile of ' + @security_users_detail.first_name + ' ' + @security_users_detail.last_name
    end

    @submit_button_text = 'Save Changes'
    @security_users_detail = SecurityUsersDetail.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  # PUT /security_users_details/1
  # PUT /security_users_details/1.json
  def update
    @security_users_detail = SecurityUsersDetail.find(params[:id])

    if current_user.id == @security_users_detail.security_user_id
      @current_title_text = 'My Profile'
    else
      @current_title_text = 'My Profile of ' + @security_users_detail.first_name + ' ' + @security_users_detail.last_name
    end

    respond_to do |format|
      if @security_users_detail.update_attributes(params[:security_users_detail])
        format.html { redirect_to @security_users_detail, notice: 'Security users detail was successfully updated.' }
        format.js
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.js
        format.json { render json: @security_users_detail.errors, status: :unprocessable_entity }
      end
    end
  end

end
