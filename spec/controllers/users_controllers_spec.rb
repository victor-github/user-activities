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

    it "doesn't follow anyone and returns errors if invalid user_id was given" do
      following = subject.current_user.follows
      post :follow, :user_id => 2, format: :json
      subject.current_user.follows.should == following 
      JSON.parse(response.body)['errors'].should == "No Such User"
    end
  end

  describe "POST unfollow user_id" do 
    login_first_user

    it "can unfollow the specified user, if a valid user_id was given" do
      to_unfollow = FactoryGirl.create(:user, :id => 2)
      subject.current_user.follow(to_unfollow)
      post :unfollow, :user_id => 2, format: :json
      subject.current_user.follows?(to_unfollow).should == false 
    end
    
    it "returns errors if user_id specified was invalid" do
      post :unfollow, :user_id => 2, format: :json
      JSON.parse(response.body)['errors'].should == "No Such User"
    end

  end

end


  
