require 'spec_helper'

describe "activities/new" do
  before(:each) do
    assign(:activity, stub_model(Activity,
      :status => "MyString",
      :user_id => 1
    ).as_new_record)
  end

  it "renders new activity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => activities_path, :method => "post" do
      assert_select "input#activity_status", :name => "activity[status]"
      assert_select "input#activity_user_id", :name => "activity[user_id]"
    end
  end
end
