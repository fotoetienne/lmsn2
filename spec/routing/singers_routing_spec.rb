require "spec_helper"

describe SingersController do
  describe "routing" do

    it "routes to #index" do
      get("/singers").should route_to("singers#index")
    end

    it "routes to #new" do
      get("/singers/new").should route_to("singers#new")
    end

    it "routes to #show" do
      get("/singers/1").should route_to("singers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/singers/1/edit").should route_to("singers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/singers").should route_to("singers#create")
    end

    it "routes to #update" do
      put("/singers/1").should route_to("singers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/singers/1").should route_to("singers#destroy", :id => "1")
    end

  end
end
