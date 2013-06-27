require 'spec_helper'

describe "hive_days/new" do
  before(:each) do
    assign(:hive_day, stub_model(HiveDay).as_new_record)
  end

  it "renders new hive_day form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => hive_days_path, :method => "post" do
    end
  end
end
