class SecurityUsersController < ApplicationController
  # GET /security_users
  # GET /security_users.json
  def index
    @security_users = SecurityUser.order(:email)

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

    if current_user.id == @security_user.id
      @current_title_text = 'My Profile Status'
    else
      @current_title_text = 'Profile Status of ' + @security_users_detail.first_name + ' ' + @security_users_detail.last_name
    end

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
    security_users_detail = SecurityUsersDetail.find_by_security_user_id(@security_user.id)
    @current_details = { is_profile_mine: true, title_text: 'Change Password' }

    unless current_user.id == @security_user.id
      @current_details[:title_text] = 'Change Password of ' + security_users_detail.first_name + ' ' + security_users_detail.last_name
      @current_details[:is_profile_mine] = false
    end

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

    (current_user.id == @security_user.id) ? mode = 'mine' : mode = 'others'

    results = @security_user.changed_password(mode,params[:security_user],params[:current_password])

    respond_to do |format|
      if  results[:status]
        format.html { redirect_to @security_user, notice: 'Security user was successfully updated.' }
        format.js
        format.json { head :no_content }
      else
        format.html { redirect_to action: 'edit' , security_user:@security_user }#render action: 'edit', locals: {security_user:@security_user} }
        format.js
        format.json { render json: @security_user.errors, status: :unprocessable_entity }
      end
    end

    #respond_to do |format|
    #  if @security_user.update_attributes(params[:security_user])
    #    format.html { redirect_to @security_user, notice: 'Security user was successfully updated.' }
    #    format.js
    #  format.json { head :no_content }
    #  else
    #    format.html { render action: 'edit' }
    #    format.json { render json: @security_user.errors, status: :unprocessable_entity }
    #  end
    #end
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
