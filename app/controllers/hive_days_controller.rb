class HiveDaysController < ApplicationController
  def index
    @hive_days = HiveDay.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hive_days }
    end
  end
  
  # grabs HiveDay from yesterday so it can be used by the view
  def dash
    #table connection stuff
    db = AWS::DynamoDB.new
    table = db.tables['apiara_development_HiveDay']
    
    table.hash_key = [:id, :string]
    table.range_key = [:date_time, :string]
    
    @the_hash_key = "sample" # make this dynamic later
    @range_low = 1.5.days.ago.to_i.to_s
    @range_high = Time.now.to_i.to_s
    
    #get the latest hive_day
    @hive_day = []
    collection = table.items.query(:hash_value => @the_hash_key, :range_value => @range_low..@range_high, 
                                    :select => [:id, :date_time, :population, :population_cumulative,
                                                :production, :production_cumulative, :data_snapshots])
                                                
    collection.each do |item_data|
      @hive_day.push(item_data.attributes)
    end
    
    # annoying quirk with how items are queried makes this necessary
    @hive_day = @hive_day.pop
        
    respond_to do |format|
      format.html # dash.html.erb
      format.json { render json: @hive_day }
    end
  end

  def hive_days_range
    #table connection stuff
    db = AWS::DynamoDB.new
    table = db.tables['apiara_development_HiveDay']
    
    table.hash_key = [:id, :string]
    table.range_key = [:date_time, :string]
    
    @the_hash_key = params[:hiveid].to_s
    @range_low = params[:datetime_low].to_s
    @range_high = params[:datetime_high].to_s

    #get the hive days
    @hive_days = []
    collection = table.items.query(:hash_value => @the_hash_key, :range_value => @range_low..@range_high, 
                                    :select => [:id, :date_time, :population, :population_cumulative,
                                                :production, :production_cumulative, :data_snapshots])

    collection.each do |item_data|
      @hive_days.push(item_data.attributes)
    end
    
    respond_to do |format|
      format.html # hive_days_range.html.erb
      format.json { render json: @hive_days }
    end
  end
end
