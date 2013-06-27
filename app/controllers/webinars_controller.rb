class WebinarsController < ApplicationController
  # GET /webinars
  # GET /webinars.json
  def index

    @search_name = nil
    @search_access_type = nil
    @search_is_active = nil

    if params[:search]
      begin
        @search_name = params[:search][:search_name]
        @search_access_type = params[:search][:search_access_type] == 'skip'? nil : params[:search][:search_access_type]
        @search_is_active = params[:search][:search_is_active] == 'skip' ? nil : params[:search][:search_is_active]
      end
    end

    @webinars = Webinar.order(:created_at).advanced_search(@search_name, @search_access_type, @search_is_active).reverse

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.json { render json: @webinars }
    end
  end

  # GET /webinars/1
  # GET /webinars/1.json
  def show
    @webinar = Webinar.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
      format.json { render json: @webinar }
    end
  end

  # GET /webinars/new
  # GET /webinars/new.json
  def new
    @webinar = Webinar.new
    @form_action_url = '/webinars'

    respond_to do |format|
      format.html # create.html.erb
      format.js { @form_action_url }
      format.json { render json: @webinar }
    end
  end

  # GET /webinars/1/edit
  def edit
    @webinar = Webinar.find(params[:id])
  end

  # POST /webinars
  # POST /webinars.json
  def create
    @webinar = Webinar.new(params[:webinar])

    respond_to do |format|
      if @webinar.save
        format.html { redirect_to @webinar, notice: 'Webinar was successfully created.' }
        format.js { @webinar }
        format.json { render json: @webinar, status: :created, location: @webinar }
      else
        format.html { render action: 'new' }
        format.js { @webinar }
        format.json { render json: @webinar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /webinars/1
  # PUT /webinars/1.json
  def update
    @webinar = Webinar.find(params[:id])

    respond_to do |format|
      if @webinar.update_attributes(params[:webinar])
        format.html { redirect_to @webinar, notice: 'Webinar was successfully updated.' }
        format.js
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @webinar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /webinars/1
  # DELETE /webinars/1.json
  def destroy
    @current_id = params[:id]

    @webinar = Webinar.find(params[:id])
    @webinar.destroy

    respond_to do |format|
      format.html { redirect_to webinars_url }
      format.js { @current_id }
      format.json { head :no_content }
    end
  end

end
