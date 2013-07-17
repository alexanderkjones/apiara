require 'spec_helper'

describe "hive_events/edit" do
  before(:each) do
    @hive_event = assign(:hive_event, stub_model(HiveEvent))
  end

  it "renders the edit hive_event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => hive_events_path(@hive_event), :method => "post" do
    end
  end
end
