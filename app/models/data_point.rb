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
    if data["value"]["event"] != "clear"
      HiveEvent.new_event(data)
    end
    
    # add to raw data store
    DataPoint.create(:id => data["value"]["id"], :date_time => data["value"]["date_time"],
                      :voltage => data["value"]["voltage"], :weight => data["value"]["weight"],
                      :temp => data["value"]["temp"], :event => data["value"]["event"])
    
    time = Time.at(data["value"]["date_time"])
    # check if at end of the day. if true, start HiveDays tasks
    if time.hour == 23 && time.min >= 55
     # once we hook up the hive_id, we can do this
     # HiveDay.daily_tasks(data["hive_id"])
    end
  end
end