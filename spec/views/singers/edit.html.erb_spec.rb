require 'spec_helper'

describe "singers/edit" do
  before(:each) do
    @singer = assign(:singer, stub_model(Singer,
      :name => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit singer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => singers_path(@singer), :method => "post" do
      assert_select "input#singer_name", :name => "singer[name]"
      assert_select "input#singer_user_id", :name => "singer[user_id]"
    end
  end
end
