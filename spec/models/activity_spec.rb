require 'spec_helper'

describe Activity do
  subject { FactoryGirl.create(:activity) }
  it { should be_valid }
  
  it "should not be valid with a blank status" do
    activity = FactoryGirl.create(:activity)
    activity.status = ""
    activity.should_not be_valid
  end

end
