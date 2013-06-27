class SecurityUsersRolesController < ApplicationController
  # GET /security_users_roles
  # GET /security_users_roles.json
  def index
    @security_users_roles = SecurityUsersRole.order('role')

    respond_to do |format|
      format.html # index.html.erb
      format.js { @security_users_roles }
      format.json { render json: @security_users_roles }
    end
  end

  # GET /security_users_roles/1
  # GET /security_users_roles/1.json
  def show
    @security_users_role = SecurityUsersRole.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js { @security_users_role }
      format.json { render json: @security_users_role }
    end
  end

  # GET /security_users_roles/new
  # GET /security_users_roles/new.json
  def new
    @security_users_role = SecurityUsersRole.new

    respond_to do |format|
      format.html # new.html.erb
      format.js { @security_users_role }
      format.json { render json: @security_users_role }
    end
  end

  # GET /security_users_roles/1/edit
  def edit
    @security_users_role = SecurityUsersRole.find(params[:id])
  end

  # POST /security_users_roles
  # POST /security_users_roles.json
  def create
    @security_users_role = SecurityUsersRole.new(params[:security_users_role])

    respond_to do |format|
      if @security_users_role.save
        format.html { redirect_to @security_users_role, notice: 'Security users role was successfully created.' }
        format.js { @security_users_role }
        format.json { render json: @security_users_role, status: :created, location: @security_users_role }
      else
        format.html { render action: "new" }
        format.js { @security_users_role}
        format.json { render json: @security_users_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /security_users_roles/1
  # PUT /security_users_roles/1.json
  def update
    @security_users_role = SecurityUsersRole.find(params[:id])

    respond_to do |format|
      if @security_users_role.update_attributes(params[:security_users_role])
        format.html { redirect_to @security_users_role, notice: 'Security users role was successfully updated.' }
        format.js { @security_users_role }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.js { @security_users_role }
        format.json { render json: @security_users_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /security_users_roles/1
  # DELETE /security_users_roles/1.json
  def destroy
    @security_users_role = SecurityUsersRole.find(params[:id])
    @security_users_role.destroy

    respond_to do |format|
      format.html { redirect_to security_users_roles_url }
      format.js { @security_users_role }
      format.json { head :no_content }
    end
  end
end
