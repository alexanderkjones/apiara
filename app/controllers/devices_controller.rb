class DevicesController < ApplicationController
  before_filter :authenticate_user!

  def all_devices
    if current_user.admin?
      @devices = Device.all
  
      respond_to do |format|
        format.html # all_devices.html.erb
        format.json { render json: @devices }
      end
    else
      redirect_to unauthorized_path
    end
  end

  def index
    @devices = Device.find(:all, :where => {:userid => current_user.id})

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @devices }
    end
  end

  def show
    @device = Device.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @device }
    end
  end

  # GET /devices/new
  # GET /devices/new.json
  def new
    if current_user.admin?
      @device = Device.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @device }
      end
    else
      redirect_to unauthorized_path
    end
  end

  # GET /devices/1/edit
  def edit
    @device = Device.find(params[:id])
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(:userid => current_user.id, :deviceid => params[:device][:deviceid], :hiveid => params[:device][:hiveid], 
                          :state => params[:device][:state], :version => params[:device][:version], :details => params[:device][:details])
#    @device = Device.new(params[:device])

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render json: @device, status: :created, location: @device }
      else
        format.html { render action: "new" }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /devices/1
  # PUT /devices/1.json
  def update
    @device = Device.find(params[:id])

    respond_to do |format|
      if @device.update_attributes(params[:device])
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device = Device.find(params[:id])
    @device.destroy

    respond_to do |format|
      format.html { redirect_to devices_url }
      format.json { head :no_content }
    end
  end
end
