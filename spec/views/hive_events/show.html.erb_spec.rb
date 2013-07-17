require 'spec_helper'

describe "hive_events/show" do
  before(:each) do
    @hive_event = assign(:hive_event, stub_model(HiveEvent))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
