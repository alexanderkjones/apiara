class DataPoint < AWS::Record::HashModel
  string_attr :id #HashKey
  string_attr :date_time #RangeKey
  float_attr :voltage
  float_attr :weight
  float_attr :temp
  string_attr :event
  
  # pick through sent data to get raw data,
  # events, and to kick off HiveDays tasks
  def self.review(data)
    puts "---------------"
    puts data.to_json
    puts "---------------"
    puts data["value"]["date_time"]
    puts "---------------"
    if data["value"]["event"]
      # create new hive_event
      # HiveEvent.new(blah)
    end
    
    # add to raw data store
    # DataPoint.new(blah)
    DataPoint.create(:id => data["value"]["id"], :date_time => data["value"]["date_time"],
                      :voltage => data["value"]["voltage"], :weight => data["value"]["weight"],
                      :temp => data["value"]["temp"], :event => data["value"]["event"])
    
    #time = Time.at(data["date+time"])
    # check if at end of the day. if true, start HiveDays tasks
    #if time.hour == 23 && time.min >= 55
    #  HiveDay.daily_tasks(data["hive_id"])
    #end
  end
end