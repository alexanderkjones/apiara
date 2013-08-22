class Device < AWS::Record::Model
  string_attr :hiveid
  string_attr :deviceid
  string_attr :userid
  string_attr :state
  string_attr :version
  string_attr :details
  #stats
end
