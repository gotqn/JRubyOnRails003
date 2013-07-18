class IssuesController < ApplicationController
  # GET /issues
  # GET /issues.json
  def index

    @search = Issue.search(params[:q])
    @issues = @search.result.order(:created_at)

    respond_to do |format|
      format.html # index.html.erb
      format.js { @issues }
      format.json { render json: @issues }
    end
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    @issue = Issue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js { @issue }
      format.json { render json: @issue }
    end
  end

  # GET /issues/new
  # GET /issues/new.json
  def new
    @issue = Issue.new

    respond_to do |format|
      format.html # new.html.erb
      format.js { @issue }
      format.json { render json: @issue }
    end
  end

  # GET /issues/1/edit
  def edit
    @issue = Issue.find(params[:id])
    @mode = 'edit'

    respond_to do |format|
      format.html # show.html.erb
      format.js { @issue }
      format.json { render json: @issue }
    end
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(params[:issue])
    @issue.is_proceed = 0

    respond_to do |format|
      if @issue.save
        @issue.send_issue_notification
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.js { @issue }
        format.json { render json: @issue, status: :created, location: @issue }
      else
        format.html { render action: 'new' }
        format.js { @issue }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /issues/1
  # PUT /issues/1.json
  def update
    @issue = Issue.find(params[:id])

    respond_to do |format|
      if @issue.update_attributes(params[:issue])
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.js { @issue }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.js { @issue }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue = Issue.find(params[:id])
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to issues_url }
      format.js
      format.json { head :no_content }
    end
  end
end
