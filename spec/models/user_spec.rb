require 'spec_helper'

describe User do
  before(:each) do
    @u1 = FactoryGirl.create(:user)
    @u2 = FactoryGirl.create(:user)
  end
  
  it "can follow another user" do
    @u1.follow(@u2)
    @u1.follows.should include(@u2)
    @u1.follows?(@u2).should be_true
  end

  it "cannot follow oneself" do
    @u1.follow(@u1).should == false
    @u1.follows?(@u1).should == false
  end

  it "can unfollow a user" do
    @u1.unfollow(@u2)
    @u1.follows?(@u2).should == false
  end 

  it "can add an activity" do
    a = @u1.add_activity("status")
    @u1.activities.should include(a)
  end
end
