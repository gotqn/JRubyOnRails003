class SecurityUsersManageSecuritiesController < ApplicationController
  # GET /security_users_manage_securities
  # GET /security_users_manage_securities.json
  def index

    @search = SecurityUser.search(params[:q])
    @security_users = @search.result.order(:email)

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @security_users }
    end

  end

  # GET /security_users_manage_securities/1
  # GET /security_users_manage_securities/1.json
  def show
    @security_user = SecurityUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render json: @security_user }
    end
  end

  # GET /security_users_manage_securities/1/edit
  def edit
    @security_user = SecurityUser.find(params[:id])
    @security_users_roles = SecurityUsersRole.order(:role)

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render json: @security_user }
    end
  end

  # PUT /security_users_manage_securities/1
  # PUT /security_users_manage_securities/1.json
  def update
    @security_user = SecurityUser.find(params[:id])
    #@security_users_roles = SecurityUsersRole.order(:role)

    respond_to do |format|
      if @security_user.manage_security_users_roles(params[:roles])
        #format.html { redirect_to @security_user, notice: 'Security users manage security was successfully updated.' }
        format.js
        format.json { head :no_content }
      else
        #format.html { render action: 'edit' }
        format.js
        format.json { render json: @security_user.errors, status: :unprocessable_entity }
      end
    end
  end

end
