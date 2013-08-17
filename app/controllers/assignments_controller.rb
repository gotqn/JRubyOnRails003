class AssignmentsController < ApplicationController
  # GET /assignments
  # GET /assignments.json
  def index
    results =  Assignment.new.get_assignments_by_render_mode(params[:render_mode], current_user.id, params[:q])
    @assignments = results[:assignments]

    @params = { render_mode:params[:render_mode],
                user_mode: current_user.get_assignment_access,
                search_options: results[:search_options] }

    #@search = SecurityUser.search(params[:q])
    #@security_users = @search.result.order(:email)


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

    has_security_access = true

    case current_user.get_assignment_access
      when 'manager'
        @render_params = { mode: 'manager', params: SecurityUsersRole.get_users_names_by_roles(['Student','Instructor']) }
      when 'instructor'
        @render_params = { mode: 'instructor', params: SecurityUsersRole.get_users_names_by_roles(['Student']) }
      when 'student'
        @render_params = { mode: 'student', params: SecurityUsersRole.get_users_names_by_roles(['Instructor']) }
      else
        has_security_access = false
    end

    respond_to do |format|
      if has_security_access
        format.html # new.html.erb
        format.json { render json: @assignment }
      else
        # rendered system message for no access
      end
    end
  end

  # GET /assignments/1/edit
  def edit
    @assignment = Assignment.find(params[:id])
  end

  # POST /assignments
  # POST /assignments.json
  def create

    @assignment = Assignment.new

    if current_user.is_security_user_instructor
      if params.has_key?(:security_users) and  params[:security_users].has_key?(:student_id)
        result = @assignment.instantiate_private(params[:security_users][:student_id],1,current_user.id,0,params[:assignment],1)
      else
        result = @assignment.instantiate_public(current_user.id,params[:assignment])
      end
    else
      result = @assignment.instantiate_private(current_user.id,0,params[:security_users][:instructor_id],1,params[:assignment],0)
    end

    respond_to do |format|
      if result[:status] == 'ok' and @assignment.save
        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render json: @assignment, status: :created, location: @assignment }
      else
        @render_params = result[:render_params]
        @assignment.errors.add(:base, result[:message]) unless result[:status] == 'ok'

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
        format.html { render action: 'edit' }
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
