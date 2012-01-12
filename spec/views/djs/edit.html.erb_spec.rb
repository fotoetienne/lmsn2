require 'spec_helper'

describe "djs/edit" do
  before(:each) do
    @dj = assign(:dj, stub_model(Dj,
      :name => "MyString",
      :user_id => 1,
      :public => false,
      :free => false,
      :promocode => "MyString"
    ))
  end

  it "renders the edit dj form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => djs_path(@dj), :method => "post" do
      assert_select "input#dj_name", :name => "dj[name]"
      assert_select "input#dj_user_id", :name => "dj[user_id]"
      assert_select "input#dj_public", :name => "dj[public]"
      assert_select "input#dj_free", :name => "dj[free]"
      assert_select "input#dj_promocode", :name => "dj[promocode]"
    end
  end
end
