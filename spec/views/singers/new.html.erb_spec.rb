require 'spec_helper'

describe "singers/new" do
  before(:each) do
    assign(:singer, stub_model(Singer,
      :name => "MyString",
      :user_id => 1
    ).as_new_record)
  end

  it "renders new singer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => singers_path, :method => "post" do
      assert_select "input#singer_name", :name => "singer[name]"
      assert_select "input#singer_user_id", :name => "singer[user_id]"
    end
  end
end
