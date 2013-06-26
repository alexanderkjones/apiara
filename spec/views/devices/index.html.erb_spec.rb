require 'spec_helper'

describe "devices/index" do
  before(:each) do
    assign(:devices, [
      stub_model(Device),
      stub_model(Device)
    ])
  end

  it "renders a list of devices" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
