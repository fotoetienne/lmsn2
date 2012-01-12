require "spec_helper"

describe DjsController do
  describe "routing" do

    it "routes to #index" do
      get("/djs").should route_to("djs#index")
    end

    it "routes to #new" do
      get("/djs/new").should route_to("djs#new")
    end

    it "routes to #show" do
      get("/djs/1").should route_to("djs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/djs/1/edit").should route_to("djs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/djs").should route_to("djs#create")
    end

    it "routes to #update" do
      put("/djs/1").should route_to("djs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/djs/1").should route_to("djs#destroy", :id => "1")
    end

  end
end
