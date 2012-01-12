require 'spec_helper'

describe "djs/new" do
  before(:each) do
    assign(:dj, stub_model(Dj,
      :name => "MyString",
      :user_id => 1,
      :public => false,
      :free => false,
      :promocode => "MyString"
    ).as_new_record)
  end

  it "renders new dj form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => djs_path, :method => "post" do
      assert_select "input#dj_name", :name => "dj[name]"
      assert_select "input#dj_user_id", :name => "dj[user_id]"
      assert_select "input#dj_public", :name => "dj[public]"
      assert_select "input#dj_free", :name => "dj[free]"
      assert_select "input#dj_promocode", :name => "dj[promocode]"
    end
  end
end
