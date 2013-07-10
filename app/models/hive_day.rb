class HiveDay < AWS::Record::HashModel
  string_attr :id #HashKey, this will be the hiveid
  string_attr :date_time #RangeKey
  
  float_attr :population #counter
  float_attr :population_cumulative #today's pop + yesterday's population_cumulative
  float_attr :production #counter
  float_attr :production_cumulative #today's production + yesterday's production_cumulative
  float_attr :max_population
  float_attr :max_space #need to figure out how to calculate this and what to do with it
  
  string_attr :data_snapshots #we can store the data snapshots as a string. first, we convert to json, then to string
  
  
  def self.daily_tasks(hive_id)
    day_points = get_day_points(hive_id)
    #12am to 5am
    morning_evaporation = get_morning_evaporation(day_points)

    #5am to min
    population = calc_population(day_points)
    
    #night evaporation from sundown to midnight
    night_evaporation = get_night_evaporation(day_points)
    
    #5am to max
    production = calc_production(day_points) - night_evaporation

    #create snapshots for display
    snapshots = create_snapshots(day_points, 50)

    #table connection stuff
    db = AWS::DynamoDB.new
    table = db.tables['apiara_development_HiveDay']
    
    table.hash_key = [:id, :string]
    table.range_key = [:date_time, :string]
    
    range_low = 1.5.days.ago.to_i.to_s
    range_high = Time.now.to_i.to_s

    #get the data from yesterday
    the_array = []
    collection = table.items.query(:hash_value => hive_id, :range_value => range_low..range_high, 
                                    :select => [:population_cumulative, :production_cumulative, :max_population])

    collection.each do |item_data|
      the_array.push(item_data.attributes)
    end
    
    population_cumulative = calc_new_population_cumulative(population, the_array.first["population_cumulative"])
    production_cumulative = calc_new_production_cumulative(production, the_array.first["production_cumulative"])
    max_population = calc_max_population(population_cumulative,the_array.first["max_population"])
    
    #create new HiveDay record
    hiveday = HiveDay.create(:id => hive_id, :date_time => Time.now.to_i, :population => population, 
                              :population_cumulative => population_cumulative, :production => production, 
                              :production_cumulative => production_cumulative, :max_population => max_population,
                              :data_snapshots => snapshots)
    hiveday.save
  end
  
  #gets the 288 data points for yesterday
  def self.get_day_points(hive_id)
    db = AWS::DynamoDB.new
    table = db.tables['hive_data_store']
    
    table.hash_key = [:id, :string]
    table.range_key = [:date_time, :number]
    
    #12am to 11:59:59pm
    range_low = Time.local(1.day.ago.year,1.day.ago.month,1.day.ago.day,0,0).to_i
    range_high = Time.local(1.day.ago.year,1.day.ago.month,1.day.ago.day,23,59,59).to_i
    
    #top one uses sample data, bottom one will be for production
    collection = table.items.query(:hash_value => hive_id, :range_value => 1366430400..1366516799, :select => [:date_time, :weight])
#    collection = table.items.query(:hash_value => hive_id, :range_value => range_low..range_high, :select => [:date_time, :weight])

    array = []
    
    collection.each do |f|
      array.push(f.attributes)
    end
    
    return array
  end

  def self.get_morning_evaporation(day_points)
    # calculates how much evaporation occurs in the morning from 12am to 5am
    weight_array = []
    #12am to 5am
    (0..60).each do |f|
      weight_array.push(day_points[f]["weight"])
    end
    
    return weight_array.first.to_f - weight_array.last.to_f
  end

  def self.get_night_evaporation(day_points)
    # calculates how much evaporation occurs in the night
    weight_array = []
    (60..(day_points.size-1)).each do |f|
      weight_array.push(day_points[f]["weight"])
    end
    
    return weight_array.max - day_points.last["weight"]
  end
  
  def self.calc_population(day_points)
    # subtract minimum weight of the day from beginning of the day's weight to get population
    weight_array = []
    (0..(day_points.size-1)).each do |f|
      weight_array.push(day_points[f]["weight"])
    end
    
    starting_weight = day_points[60]["weight"] #5am
    min_weight = day_points[weight_array.index(weight_array.min)]["weight"]
    
    return starting_weight - min_weight
  end
  
  def self.calc_new_population_cumulative(population, yesterday_population_cumulative)
    # add sum total population today to yesterday's total population
    return population + yesterday_population_cumulative
  end
  
  def self.calc_production(day_points)
    # subtract beginning of the day from end of the day's weight to get today's production
    weight_array = []
    (0..(day_points.size-1)).each do |f|
      weight_array.push(day_points[f]["weight"])
    end
    
    starting_weight = day_points[60]["weight"] #5am
    end_weight = day_points[weight_array.index(weight_array.max)]["weight"]
    
    return end_weight - starting_weight
  end
  
  def self.calc_new_production_cumulative(production, yesterday_production_cumulative)
    # add sum total population today to yesterday's total population
    return production + yesterday_production_cumulative
  end
  
  # need to figure out how we want to use this
  # reset seasonally? yearly? monthly?
  def self.calc_max_population(population_cumulative, max_population)
    return (population_cumulative > max_population) ? population_cumulative : max_population
  end
  
  # this is imperfect... arrays are coming in JUST too small or JUST too big
  # fix in here for too big, working out solution for too small
  def self.create_snapshots(day_points, how_many_points)
    #create snapshots to use for display, takes the day_points array and how many points to return
    factor = day_points.size.to_f / how_many_points.to_f
    
    factor = factor.round
    
    array = []
    (0..(day_points.size-1)).each do |f|
      if ((f-1) % factor) == 0 || f == 0 || f == (day_points.size-1)
        array.push(day_points[f])
      end
    end
    
    #if array is too big, pop off last item
    if array.size > how_many_points
      array.pop
    end
    
    #if array is still too big, pop off the first item
    if array.size > how_many_points
      array = array.reverse
      array.pop
      array = array.reverse
    end
    
    return array.to_json.to_s
  end
end