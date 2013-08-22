class HivesController < ApplicationController
  before_filter :authenticate_user!, :except => [:all_hives, :show]

  def all_hives
    if current_user.admin?
      @hives = Hive.all
  
      respond_to do |format|
        format.html # all_hives.html.erb
        format.json { render json: @hives }
      end
    else
      redirect_to unauthorized_path
    end
  end

  def index
    @hives = Hive.find(:all, :where => {:userid => current_user.id})

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hives }
    end
  end

  # GET /hives/1
  # GET /hives/1.json
  def show
    @hive = Hive.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hive }
    end
  end

  # GET /hives/new
  # GET /hives/new.json
  def new
    if current_user.admin?
      @hive = Hive.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @hive }
      end
    else
      redirect_to unauthorized_path
    end
  end

  # GET /hives/1/edit
  def edit
    # @hive = Hive.find(params[:id])
  end

  # POST /hives
  # POST /hives.json
  def create
    @hive = Hive.new(:userid => current_user.id, :hiveid => params[:hive][:hiveid], 
                      :deviceid => params[:hive][:deviceid], :details => params[:hive][:details])

    respond_to do |format|
      if @hive.save
        format.html { redirect_to @hive, notice: 'Hive was successfully created.' }
        format.json { render json: @hive, status: :created, location: @hive }
      else
        format.html { render action: "new" }
        format.json { render json: @hive.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hives/1
  # PUT /hives/1.json
  def update
    @hive = Hive.find(params[:id])

    respond_to do |format|
      if @hive.update_attributes(params[:hive])
        format.html { redirect_to @hive, notice: 'Hive was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hive.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hives/1
  # DELETE /hives/1.json
  def destroy
    @hive = Hive.find(params[:id])
    @hive.destroy

    respond_to do |format|
      format.html { redirect_to hives_url }
      format.json { head :no_content }
    end
  end
end
