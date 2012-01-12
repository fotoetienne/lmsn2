require 'spec_helper'

describe "songs/edit" do
  before(:each) do
    @song = assign(:song, stub_model(Song,
      :dj_id => 1,
      :artist => "MyString",
      :title => "MyString",
      :disc => "MyString",
      :identifier => "MyString",
      :notes => "MyText"
    ))
  end

  it "renders the edit song form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => songs_path(@song), :method => "post" do
      assert_select "input#song_dj_id", :name => "song[dj_id]"
      assert_select "input#song_artist", :name => "song[artist]"
      assert_select "input#song_title", :name => "song[title]"
      assert_select "input#song_disc", :name => "song[disc]"
      assert_select "input#song_identifier", :name => "song[identifier]"
      assert_select "textarea#song_notes", :name => "song[notes]"
    end
  end
end
