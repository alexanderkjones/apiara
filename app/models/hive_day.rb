class HiveDay < AWS::Record::HashModel
  string_attr :hiveid #HashKey
  datetime_attr :date #RangeKey
  
  integer_attr :population #counter
  integer_attr :population_cumulative #today's pop + yesterday's population_cumulative
  integer_attr :production #counter
  integer_attr :production_cumulative #today's production + yesterday's production_cumulative
  
  def add_to_pop_counter
    # Build model method that adds to pop_counter as a function of 
    # the change in weight from sunrise to the bottom of the bell 
    # curve just before bees start coming back to the hive. Said 
    # another way, the difference between the morning weight and 
    # the lowest weight of the hive in a normal day or the middle of
    # the day before the weight begins to increase as the bees start 
    # coming home.
  end
  
  def calc_new_population_cumulative
    # add sum total population today to yesterday's total population
    # population_cumulative = yesterday_population_cumulative + population
  end
  
  def calc_todays_production
    # subtract beginning of the day from end of the day's weight to get today's production
    # production = end_weight - beginning_weight
  end
  
  def calc_new_production_cumulative
    # add sum total population today to yesterday's total population
    # production_cumulative = yesterday_production_cumulative + production
  end
end