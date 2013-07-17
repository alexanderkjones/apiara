require 'spec_helper'

describe "hive_events/index" do
  before(:each) do
    assign(:hive_events, [
      stub_model(HiveEvent),
      stub_model(HiveEvent)
    ])
  end

  it "renders a list of hive_events" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
