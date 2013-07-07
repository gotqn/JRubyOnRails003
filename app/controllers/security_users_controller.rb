class SecurityUsersController < ApplicationController
  # GET /security_users
  # GET /security_users.json
  def index
    @search = SecurityUser.search(params[:q])
    @security_users = @search.result.order(:email)

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @security_users }
    end
  end

  # GET /security_users/1
  # GET /security_users/1.json
  def show
    @security_user = SecurityUser.find(params[:id])
    @current_title_text = @security_user.is_profile_mine(current_user.id,'My Profile Status','Profile Status of {first_name} {last_name}')

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render json: @security_user }
    end
  end

  # GET /security_users/new
  # GET /security_users/new.json
  def new
    @security_user = SecurityUser.new

    respond_to do |format|
      format.html # create.html.erb
      format.js
      format.json { render json: @security_user }
    end
  end

  # GET /security_users/1/edit
  def edit
    @security_user = SecurityUser.find(params[:id])
    @current_title_text = @security_user.is_profile_mine(current_user.id,'Change Password','Change Password of {first_name} {last_name}')

    respond_to do |format|
      format.html {@current_details}
      format.js
      format.json { render json: @security_user }
    end
  end

  # POST /security_users
  # POST /security_users.json
  def create

    @security_user = SecurityUser.new(params[:security_user])

    # Internal variables
    @security_user.activation_code = SecureRandom.hex(32)
    @security_user.registration_date = DateTime.now
    @security_user.last_log_in_date = DateTime.now
    @security_user.security_users_manage_securities.build(security_users_role: SecurityUsersRole.find_by_role('Student'))

    # Internal variables that can be overwritten by authenticated users
    @security_user.is_active ||= 0
    @security_user.language_code ||= 'EN'

    respond_to do |format|
      if verify_recaptcha(model: @security_user, attribute:'captcha', message: 'Wrong captcha input.') && @security_user.save
        @security_user.send_email_confirmation
        format.html { redirect_to @security_user, notice: 'Security user was successfully created.' }
        format.js { @security_user }
        format.json { render json: @security_user, status: :created, location: @security_user }
      else
        format.html { render action: 'new' }
        format.js { @security_user }
        format.json { render json: @security_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /security_users/1
  # PUT /security_users/1.json
  def update

    @security_user = SecurityUser.find(params[:id])

    respond_to do |format|
      if @security_user.update_attributes(params[:security_user])
        format.html { redirect_to @security_user, notice: 'Security user was successfully updated.' }
        format.js
      format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.js { @security_user }
        format.json { render json: @security_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /security_users/1
  # DELETE /security_users/1.json
  def destroy
    @security_user = SecurityUser.find(params[:id])
    @security_user.destroy

    respond_to do |format|
      format.html { redirect_to security_users_url }
      format.js
      format.json { head :no_content }
    end
  end
end
