class HiveDay < AWS::Record::HashModel
  string_attr :id #HashKey, this will be the hiveid
  string_attr :date_time #RangeKey
  
  integer_attr :population #counter
  integer_attr :population_cumulative #today's pop + yesterday's population_cumulative
  integer_attr :production #counter
  integer_attr :production_cumulative #today's production + yesterday's production_cumulative
  
  def self.daily_tasks(id, population, production)
    #table connection stuff
    db = AWS::DynamoDB.new
    table = db.tables['apiara_development_HiveDay']
    
    table.hash_key = [:id, :string]
    table.range_key = [:date_time, :string]
    
    range_low = 1.5.days.ago.to_i.to_s
    range_high = Time.now.to_i.to_s

    #get the data from yesterday
    the_array = []
    collection = table.items.query(:hash_value => id, :range_value => range_low..range_high, 
                                    :select => [:population_cumulative, :production_cumulative])

    collection.each do |item_data|
      the_array.push(item_data.attributes)
    end

    population_cumulative = calc_new_population_cumulative(population, the_array.first["population_cumulative"])
    production_cumulative = calc_new_production_cumulative(production, the_array.first["production_cumulative"])
    
    hiveday = HiveDay.create(:id => id, :date_time => Time.now.to_i.to_s, :population => population, 
                              :population_cumulative => population_cumulative, :production => production, 
                              :production_cumulative => production_cumulative)
    hiveday.save
  end
  
  def self.add_to_pop_counter
    # Build model method that adds to pop_counter as a function of 
    # the change in weight from sunrise to the bottom of the bell 
    # curve just before bees start coming back to the hive. Said 
    # another way, the difference between the morning weight and 
    # the lowest weight of the hive in a normal day or the middle of
    # the day before the weight begins to increase as the bees start 
    # coming home.
  end
  
  def self.calc_new_population_cumulative(population, yesterday_population_cumulative)
    # add sum total population today to yesterday's total population
    return population + yesterday_population_cumulative
  end
  
  def self.calc_todays_production
    # subtract beginning of the day from end of the day's weight to get today's production
    # production = end_weight - beginning_weight
  end
  
  def self.calc_new_production_cumulative(production, yesterday_production_cumulative)
    # add sum total population today to yesterday's total population
    return production + yesterday_production_cumulative
  end
end