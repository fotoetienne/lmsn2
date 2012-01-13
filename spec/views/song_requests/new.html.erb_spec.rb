require 'spec_helper'

describe "song_requests/new" do
  before(:each) do
    assign(:song_request, stub_model(SongRequest,
      :dj_id => 1,
      :song_id => 1,
      :singer_id => 1,
      :singer_name => "MyString",
      :key => "MyString",
      :comments => "MyString",
      :archived => false
    ).as_new_record)
  end

  it "renders new song_request form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => song_requests_path, :method => "post" do
      assert_select "input#song_request_dj_id", :name => "song_request[dj_id]"
      assert_select "input#song_request_song_id", :name => "song_request[song_id]"
      assert_select "input#song_request_singer_id", :name => "song_request[singer_id]"
      assert_select "input#song_request_singer_name", :name => "song_request[singer_name]"
      assert_select "input#song_request_key", :name => "song_request[key]"
      assert_select "input#song_request_comments", :name => "song_request[comments]"
      assert_select "input#song_request_archived", :name => "song_request[archived]"
    end
  end
end
