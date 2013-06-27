require 'spec_helper'

describe "hive_days/edit" do
  before(:each) do
    @hive_day = assign(:hive_day, stub_model(HiveDay))
  end

  it "renders the edit hive_day form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => hive_days_path(@hive_day), :method => "post" do
    end
  end
end
