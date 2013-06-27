require 'spec_helper'

describe "hive_days/index" do
  before(:each) do
    assign(:hive_days, [
      stub_model(HiveDay),
      stub_model(HiveDay)
    ])
  end

  it "renders a list of hive_days" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
