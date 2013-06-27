class SecurityUsersManageSecuritiesController < ApplicationController
  # GET /security_users_manage_securities
  # GET /security_users_manage_securities.json
  def index
    @security_users_manage_securities = SecurityUsersManageSecurity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @security_users_manage_securities }
    end
  end

  # GET /security_users_manage_securities/1
  # GET /security_users_manage_securities/1.json
  def show
    @security_users_manage_security = SecurityUsersManageSecurity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @security_users_manage_security }
    end
  end

  # GET /security_users_manage_securities/new
  # GET /security_users_manage_securities/new.json
  def new
    @security_users_manage_security = SecurityUsersManageSecurity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @security_users_manage_security }
    end
  end

  # GET /security_users_manage_securities/1/edit
  def edit
    @security_users_manage_security = SecurityUsersManageSecurity.find(params[:id])
  end

  # POST /security_users_manage_securities
  # POST /security_users_manage_securities.json
  def create
    @security_users_manage_security = SecurityUsersManageSecurity.new(params[:security_users_manage_security])

    respond_to do |format|
      if @security_users_manage_security.save
        format.html { redirect_to @security_users_manage_security, notice: 'Security users manage security was successfully created.' }
        format.json { render json: @security_users_manage_security, status: :created, location: @security_users_manage_security }
      else
        format.html { render action: "new" }
        format.json { render json: @security_users_manage_security.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /security_users_manage_securities/1
  # PUT /security_users_manage_securities/1.json
  def update
    @security_users_manage_security = SecurityUsersManageSecurity.find(params[:id])

    respond_to do |format|
      if @security_users_manage_security.update_attributes(params[:security_users_manage_security])
        format.html { redirect_to @security_users_manage_security, notice: 'Security users manage security was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @security_users_manage_security.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /security_users_manage_securities/1
  # DELETE /security_users_manage_securities/1.json
  def destroy
    @security_users_manage_security = SecurityUsersManageSecurity.find(params[:id])
    @security_users_manage_security.destroy

    respond_to do |format|
      format.html { redirect_to security_users_manage_securities_url }
      format.json { head :no_content }
    end
  end
end
