class AssignmentsController < ApplicationController
  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assignments }
    end
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    @assignment = Assignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @assignment }
    end
  end

  # GET /assignments/new
  # GET /assignments/new.json
  def new
    @assignment = Assignment.new

    params = {}

    if current_user.is_security_user_instructor
      SecurityUsersRole.find_by_role('Student').get_security_users_by_role.each do |security_user|
        security_users_details = security_user.get_security_user_details
        unless security_users_details.nil? or security_users_details.first_name.nil? or security_users_details.last_name.nil?
          params[security_user.id] = security_users_details.first_name + ' ' + security_users_details.last_name
        end
      end
      @render = { mode: 'instructor', params: params}
    else
      SecurityUsersRole.find_by_role('Instructor').get_security_users_by_role.each do |security_user|
        security_users_details = security_user.get_security_user_details
        unless security_users_details.nil? or security_users_details.first_name.nil? or security_users_details.last_name.nil?
          params[security_user.id] = security_users_details.first_name + ' ' + security_users_details.last_name
        end
      end
      @render = { mode: 'student', params: params}
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @assignment }
    end
  end

  # GET /assignments/1/edit
  def edit
    @assignment = Assignment.find(params[:id])
  end

  # POST /assignments
  # POST /assignments.json
  def create

    #@assignment = Assignment.new(params[:assignment])

    @assignment = Assignment.new

    @assignment.subject = params[:assignment][:subject]
    @assignment.technologies = params[:assignment][:technologies]
    @assignment.description = params[:assignment][:description]
    @assignment.type = 'private'
    @assignment.status = 'ongoing'
    @assignment.is_disabled = 0




    if current_user.is_security_user_instructor

    else

    end


    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render json: @assignment, status: :created, location: @assignment }
      else
        format.html { render action: 'new' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /assignments/1
  # PUT /assignments/1.json
  def update
    @assignment = Assignment.find(params[:id])

    respond_to do |format|
      if @assignment.update_attributes(params[:assignment])
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to assignments_url }
      format.json { head :no_content }
    end
  end
end
