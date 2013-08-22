class Hive < AWS::Record::Model
  string_attr :deviceid
  string_attr :hiveid
  string_attr :userid
  string_attr :details  
  #geocoding later
end
