class HiveEvent < AWS::Record::HashModel
  string_attr :id #HashKey, this will be the hiveid
  string_attr :date_time #RangeKey

  string_attr :data_snapshot
  string_attr :type
  string_attr :details  

  #create new hive event
#  def self.new_event(hive_id, data_snapshot, type, details)
  def self.new_event(data)
    #create new HiveEvent record
    HiveEvent.create(:id => data["value"]["id"], :date_time => data["value"]["date_time"], :data_snapshot => data_snapshot, 
                      :type => data["value"]["event"], :details => "details")

    # hiveday = HiveEvent.create(:id => hive_id, :date_time => Time.now.to_i, :data_snapshot => data_snapshot,
                                # :type => type, :details => details)
    # hiveday.save
  end
  
  #this method will send alert emails to users based on what event is reported
  def self.send_alert(type)
    ses = AWS::SimpleEmailService.new
    
    case type
    when "low_battery"
      #low battery
      ses.send_email(
        :subject => 'Low Battery',
        :from => 'hello@apiara.com',
        :to => 'awmitchell@email.com',
        :body_text => 'Your battery is low.',
        :body_html => 'Your battery is low.')
    when "lost_bees"
      #lost 3 lbs. of bees
      ses.send_email(
        :subject => 'Lost Bees',
        :from => 'hello@apiara.com',
        :to => 'awmitchell@email.com',
        :body_text => 'Your just lost 3 lbs. of bees.',
        :body_html => 'Your just lost 3 lbs. of bees.')
    when "nectar_flow"
      #nectar is flowing, hive gained 2 lbs.
      ses.send_email(
        :subject => 'Nectar Is Flowing!',
        :from => 'hello@apiara.com',
        :to => 'awmitchell@email.com',
        :body_text => 'Nectar is flowing! Your hive just gained 2 lbs.',
        :body_html => 'Nectar is flowing! Your hive just gained 2 lbs.')
    end
  end
end
