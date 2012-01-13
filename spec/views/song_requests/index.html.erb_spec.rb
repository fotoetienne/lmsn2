require 'spec_helper'

describe "song_requests/index" do
  before(:each) do
    assign(:song_requests, [
      stub_model(SongRequest,
        :dj_id => 1,
        :song_id => 1,
        :singer_id => 1,
        :singer_name => "Singer Name",
        :key => "Key",
        :comments => "Comments",
        :archived => false
      ),
      stub_model(SongRequest,
        :dj_id => 1,
        :song_id => 1,
        :singer_id => 1,
        :singer_name => "Singer Name",
        :key => "Key",
        :comments => "Comments",
        :archived => false
      )
    ])
  end

  it "renders a list of song_requests" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Singer Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Key".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Comments".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
