require "spec_helper"

describe HiveEventsController do
  describe "routing" do

    it "routes to #index" do
      get("/hive_events").should route_to("hive_events#index")
    end

    it "routes to #new" do
      get("/hive_events/new").should route_to("hive_events#new")
    end

    it "routes to #show" do
      get("/hive_events/1").should route_to("hive_events#show", :id => "1")
    end

    it "routes to #edit" do
      get("/hive_events/1/edit").should route_to("hive_events#edit", :id => "1")
    end

    it "routes to #create" do
      post("/hive_events").should route_to("hive_events#create")
    end

    it "routes to #update" do
      put("/hive_events/1").should route_to("hive_events#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/hive_events/1").should route_to("hive_events#destroy", :id => "1")
    end

  end
end
