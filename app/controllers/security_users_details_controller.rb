class SecurityUsersDetailsController < ApplicationController

  skip_before_filter :is_profile_complete #, only: [:edit, :new, :create, :update]

  # GET /security_users_details
  # GET /security_users_details.json
  def index
    @security_users_details = SecurityUsersDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @security_users_details }
    end
  end

  # GET /security_users_details/1
  # GET /security_users_details/1.json
  def show
    @security_users_detail = SecurityUsersDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @security_users_detail }
    end
  end

  # GET /security_users_details/new
  # GET /security_users_details/new.json
  def new
    @security_users_detail = SecurityUsersDetail.new

    respond_to do |format|
      format.html # create.html.erb
      format.json { render json: @security_users_detail }
    end
  end

  # GET /security_users_details/1/edit
  def edit
    @security_users_detail = SecurityUsersDetail.find(params[:id])
  end

  # POST /security_users_details
  # POST /security_users_details.json
  def create
    @security_users_detail = SecurityUsersDetail.new(params[:security_users_detail])

    respond_to do |format|
      if @security_users_detail.save
        format.html { redirect_to @security_users_detail, notice: 'Security users detail was successfully created.' }
        format.json { render json: @security_users_detail, status: :created, location: @security_users_detail }
      else
        format.html { render action: "new" }
        format.json { render json: @security_users_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /security_users_details/1
  # PUT /security_users_details/1.json
  def update
    @security_users_detail = SecurityUsersDetail.find(params[:id])

    respond_to do |format|
      if @security_users_detail.update_attributes(params[:security_users_detail])
        format.html { redirect_to @security_users_detail, notice: 'Security users detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @security_users_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /security_users_details/1
  # DELETE /security_users_details/1.json
  def destroy
    @security_users_detail = SecurityUsersDetail.find(params[:id])
    @security_users_detail.destroy

    respond_to do |format|
      format.html { redirect_to security_users_details_url }
      format.json { head :no_content }
    end
  end
end
