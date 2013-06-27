class HiveDaysController < ApplicationController
  # GET /hive_days
  # GET /hive_days.json
  def index
    @hive_days = HiveDay.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hive_days }
    end
  end

  # GET /hive_days/1
  # GET /hive_days/1.json
  def show
    @hive_day = HiveDay.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hive_day }
    end
  end

  # GET /hive_days/new
  # GET /hive_days/new.json
  def new
    @hive_day = HiveDay.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hive_day }
    end
  end

  # GET /hive_days/1/edit
  def edit
    @hive_day = HiveDay.find(params[:id])
  end

  # POST /hive_days
  # POST /hive_days.json
  def create
    @hive_day = HiveDay.new(params[:hive_day])

    respond_to do |format|
      if @hive_day.save
        format.html { redirect_to @hive_day, notice: 'Hive day was successfully created.' }
        format.json { render json: @hive_day, status: :created, location: @hive_day }
      else
        format.html { render action: "new" }
        format.json { render json: @hive_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hive_days/1
  # PUT /hive_days/1.json
  def update
    @hive_day = HiveDay.find(params[:id])

    respond_to do |format|
      if @hive_day.update_attributes(params[:hive_day])
        format.html { redirect_to @hive_day, notice: 'Hive day was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hive_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hive_days/1
  # DELETE /hive_days/1.json
  def destroy
    @hive_day = HiveDay.find(params[:id])
    @hive_day.destroy

    respond_to do |format|
      format.html { redirect_to hive_days_url }
      format.json { head :no_content }
    end
  end
end
