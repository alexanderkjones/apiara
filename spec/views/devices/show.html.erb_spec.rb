require 'spec_helper'

describe "devices/show" do
  before(:each) do
    @device = assign(:device, stub_model(Device))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
