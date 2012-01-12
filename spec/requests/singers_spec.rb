require 'spec_helper'

describe "Singers" do
  describe "GET /singers" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get singers_path
      response.status.should be(200)
    end
  end
end
