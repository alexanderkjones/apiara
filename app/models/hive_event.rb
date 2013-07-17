class HiveEvent < AWS::Record::HashModel
  string_attr :id #HashKey, this will be the hiveid
  string_attr :date_time #RangeKey

  string_attr :data_snapshot
  string_attr :type
  string_attr :details  
end