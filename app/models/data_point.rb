class DataPoint < AWS::Record::HashModel
  string_attr :id #HashKey, this will be the hiveid
  string_attr :raw_data
  
  # pick through sent data to get raw data,
  # events, and to kick off HiveDays tasks
  def self.review(data)
    puts "---------------"
    puts data.to_xml
    puts "---------------"
    puts data["date_time"]
    puts "---------------"
    if data["event"]
      # create new hive_event
      # HiveEvent.new(blah)
    end
    
    # add to raw data store
    # DataPoint.new(blah)
    
    #time = Time.at(data["date+time"])
    # check if at end of the day. if true, start HiveDays tasks
    #if time.hour == 23 && time.min >= 55
    #  HiveDay.daily_tasks(data["hive_id"])
    #end
  end
end