class HiveDaysController < ApplicationController
  layout "dashboard", except: [:index, :hive_days_range]
  
  def index
    @hive_days = HiveDay.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hive_days }
    end
  end
  
  # grabs HiveDay from yesterday so it can be used by the view
  def dash
    respond_to do |format|
      format.html # dash.html.erb
    end
  end
  
  def initial_dash_data
    #table connection stuff
    db = AWS::DynamoDB.new
    table = db.tables['apiara_development_HiveDay']
    
    table.hash_key = [:id, :string]
    table.range_key = [:date_time, :string]
    
    @the_hash_key = "sample" # make this dynamic later
#    @range_low = 1.5.days.ago.to_i.to_s
    @range_low = "1373321899"
#    @range_high = Time.now.to_i.to_s
    @range_high = "1373321901"
    
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

    @hive_day_snapshots = JSON.parse(@hive_day["data_snapshots"])
    @hive_day_snapshots.pop # pop off summary
    
    
    @times = []
    @weights = []
    @hive_day_snapshots.each do |h|
      temp_time = Time.at(h["date_time"].to_i)
      @times.push(temp_time.hour.to_s + ":" + temp_time.min.to_s.rjust(2,'0'))
      @weights.push(h["weight"])
    end

    respond_to do |format|
#      format.html # dash.html.erb
      format.json { render :json => {"times" => @times, "weights" => @weights}, :status => :ok }
#      format.json { render json: @hive_day }
    end
  end

  def extra_dash_data
    #table connection stuff
    db = AWS::DynamoDB.new
    table = db.tables['apiara_development_HiveDay']
    
    table.hash_key = [:id, :string]
    table.range_key = [:date_time, :string]
    
    @the_hash_key = "sample" # make this dynamic later
    @range_low = "1373321900" # 1.5.days.ago.to_i.to_s
    @range_high = "1376429644" # Time.now.to_i.to_s
    
    #get the latest hive_day
    @hive_days = []
    collection = table.items.query(:hash_value => @the_hash_key, :range_value => @range_low..@range_high, 
                                    :select => [:id, :date_time, :population, :population_cumulative,
                                                :production, :production_cumulative, :data_snapshots])
                                                
    collection.each do |item_data|
      @hive_days.push(item_data.attributes)
    end
    
    @dates = []
    @weights = []
    @hive_days.each do |h|
      the_data = JSON.parse(h["data_snapshots"])
      the_data.pop
      temp_weights = []
      the_data.each do |t|
        temp_weights.push(t["weight"])
      end
      @dates.push(Time.at(h["date_time"].to_i))
      @weights.push(temp_weights.max)
    end
    
    respond_to do |format|
      format.json { render :json => {"dates" => @dates, "weights" => @weights}, :status => :ok }
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
