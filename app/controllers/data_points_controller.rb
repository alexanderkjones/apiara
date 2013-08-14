class DataPointsController < ApplicationController
  def index
    #send incoming data to DataPoint model
    DataPoint.review(params[:data_point])

    respond_to do |format|
      format.html { render text: "GOOD" }# index.html.erb
      format.json { render json: "GOOD" }
    end
  end
end