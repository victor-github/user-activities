require 'spec_helper'

describe User do
  before(:each) do
    @u1 = FactoryGirl.create(:user)
    @u2 = FactoryGirl.create(:user)
  end
  
  it "can follow another user" do
    @u1.follow(@u2)
    @u1.followed.should include(@u2)
    @u1.follows?(@u2).should be_true
  end

  it "cannot follow oneself" do
  end

  it "can unfollow a user" do
  end 
end
