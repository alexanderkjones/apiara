class HiveEventsController < ApplicationController
  # GET /hive_events
  # GET /hive_events.json
  def index
    @hive_events = HiveEvent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hive_events }
    end
  end

  # GET /hive_events/1
  # GET /hive_events/1.json
  def show
    @hive_event = HiveEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hive_event }
    end
  end

  # GET /hive_events/new
  # GET /hive_events/new.json
  def new
    @hive_event = HiveEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hive_event }
    end
  end

  # GET /hive_events/1/edit
  def edit
    @hive_event = HiveEvent.find(params[:id])
  end

  # POST /hive_events
  # POST /hive_events.json
  def create
    @hive_event = HiveEvent.new(params[:hive_event])

    respond_to do |format|
      if @hive_event.save
        format.html { redirect_to @hive_event, notice: 'Hive event was successfully created.' }
        format.json { render json: @hive_event, status: :created, location: @hive_event }
      else
        format.html { render action: "new" }
        format.json { render json: @hive_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hive_events/1
  # PUT /hive_events/1.json
  def update
    @hive_event = HiveEvent.find(params[:id])

    respond_to do |format|
      if @hive_event.update_attributes(params[:hive_event])
        format.html { redirect_to @hive_event, notice: 'Hive event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hive_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hive_events/1
  # DELETE /hive_events/1.json
  def destroy
    @hive_event = HiveEvent.find(params[:id])
    @hive_event.destroy

    respond_to do |format|
      format.html { redirect_to hive_events_url }
      format.json { head :no_content }
    end
  end
end
