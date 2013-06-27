require "spec_helper"

describe HiveDaysController do
  describe "routing" do

    it "routes to #index" do
      get("/hive_days").should route_to("hive_days#index")
    end

    it "routes to #new" do
      get("/hive_days/new").should route_to("hive_days#new")
    end

    it "routes to #show" do
      get("/hive_days/1").should route_to("hive_days#show", :id => "1")
    end

    it "routes to #edit" do
      get("/hive_days/1/edit").should route_to("hive_days#edit", :id => "1")
    end

    it "routes to #create" do
      post("/hive_days").should route_to("hive_days#create")
    end

    it "routes to #update" do
      put("/hive_days/1").should route_to("hive_days#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/hive_days/1").should route_to("hive_days#destroy", :id => "1")
    end

  end
end
