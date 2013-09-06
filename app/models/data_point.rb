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
    unless data["value"]["event"].blank?
      HiveEvent.new_event(data)
    end
    
    # add to raw data store
    DataPoint.create(:id => data["value"]["id"], :date_time => data["value"]["date_time"],
                      :voltage => data["value"]["voltage"], :weight => data["value"]["weight"],
                      :temp => data["value"]["temp"], :event => data["value"]["event"])
    
    time = Time.at(data["value"]["date_time"])
    puts "---time---"
    puts time.hour
    puts time.min
    puts "----------"
    # check if at end of the day. if true, start HiveDays tasks
    if time.hour == 16 && time.min >= 26
      puts "----------------"
      puts "HI"
      puts "----------------"
      hiveid = Device.find(:first, :where => {:deviceid => data["value"]["id"]}).hiveid
      # hiveid = Device.find_by_id(data["value"]["id"]).hiveid
      HiveDay.daily_tasks(hiveid)
    end
  end
end