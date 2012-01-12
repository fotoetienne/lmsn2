require 'spec_helper'

describe "djs/index" do
  before(:each) do
    assign(:djs, [
      stub_model(Dj,
        :name => "Name",
        :user_id => 1,
        :public => false,
        :free => false,
        :promocode => "Promocode"
      ),
      stub_model(Dj,
        :name => "Name",
        :user_id => 1,
        :public => false,
        :free => false,
        :promocode => "Promocode"
      )
    ])
  end

  it "renders a list of djs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Promocode".to_s, :count => 2
  end
end
