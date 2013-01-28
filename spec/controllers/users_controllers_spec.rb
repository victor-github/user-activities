require 'spec_helper'

describe UsersController do

  def valid_attributes
    {}
  end

  describe "POST follow user_id" do 
    login_first_user
    it "can follow the specified user, if a valid user_id was given" do
      to_follow = FactoryGirl.create(:user, :id => 2)
      post :follow, :user_id => 2, format: :json
      subject.current_user.follows?(to_follow).should == true

    end
  end

  describe "POST follow user_id" do 
    login_first_user
    it "can follow the specified user, if a valid user_id was given" do
      to_follow = FactoryGirl.create(:user, :id => 2)
      subject.current_user.follow(to_follow)
      post :unfollow, :user_id => 2, format: :json
      subject.current_user.follows?(to_follow).should == false 

    end
  end

end


  
