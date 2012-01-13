require "spec_helper"

describe SongRequestsController do
  describe "routing" do

    it "routes to #index" do
      get("/song_requests").should route_to("song_requests#index")
    end

    it "routes to #new" do
      get("/song_requests/new").should route_to("song_requests#new")
    end

    it "routes to #show" do
      get("/song_requests/1").should route_to("song_requests#show", :id => "1")
    end

    it "routes to #edit" do
      get("/song_requests/1/edit").should route_to("song_requests#edit", :id => "1")
    end

    it "routes to #create" do
      post("/song_requests").should route_to("song_requests#create")
    end

    it "routes to #update" do
      put("/song_requests/1").should route_to("song_requests#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/song_requests/1").should route_to("song_requests#destroy", :id => "1")
    end

  end
end
