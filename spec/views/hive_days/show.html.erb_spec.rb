require 'spec_helper'

describe "hive_days/show" do
  before(:each) do
    @hive_day = assign(:hive_day, stub_model(HiveDay))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
