require 'spec_helper'

describe "djs/show" do
  before(:each) do
    @dj = assign(:dj, stub_model(Dj,
      :name => "Name",
      :user_id => 1,
      :public => false,
      :free => false,
      :promocode => "Promocode"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Promocode/)
  end
end
