require 'spec_helper'

describe "hive_events/new" do
  before(:each) do
    assign(:hive_event, stub_model(HiveEvent).as_new_record)
  end

  it "renders new hive_event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => hive_events_path, :method => "post" do
    end
  end
end
