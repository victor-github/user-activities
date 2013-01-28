require 'spec_helper'

describe ActivitiesController do

  def valid_attributes
    { "status" => "My Updated Status" }
  end

  describe "GET all activities for given user_id" do
    before(:each) do
      FactoryGirl.create(:user, :id => 2)
    end
    it "assigns all activities as @activities" do
      activity1 = FactoryGirl.create(:activity, :user_id => 2)
      activity2 = FactoryGirl.create(:activity, :user_id => 2)
      get :index, { :user_id => 2 }, {}
      assigns(:activities).should eq([activity1, activity2])
    end
  end

  describe "GET /latest_followed" do
    login_first_user

    before(:each) do
      @u1 = subject.current_user
      @u2 = FactoryGirl.create(:user, :id => 2)
      @u3 = FactoryGirl.create(:user, :id => 3)
      @u1.follow(@u2)
      @a1 = @u2.add_activity("User 2 - Activity 1")
      @a2 = @u2.add_activity("User 2 - Activity 2")
      @a3 = @u3.add_activity("User 3 - Activity 1")
    end

    it "gets current_user's latest activities for followed users" do
      get :latest_followed, {}, {}
      assigns(:activities).should == [@a1, @a2]
    end


  end

  describe "GET show" do
    it "assigns the requested activity as @activity" do
      activity = Activity.create! valid_attributes
      get :show, {:id => activity.to_param}, {}
      assigns(:activity).should eq(activity)
    end
  end


  describe "POST create" do
    login_first_user

    it "should have a current user" do
      subject.current_user.should_not be_nil
    end

    describe "with a valid, non-empty status" do
      it "creates a new user activity for current_user" do
        expect {
          post :create, :activity => valid_attributes, :format => :json
        }.to change(Activity, :count).by(1)
      end

      it "assigns a newly created activity as @activity" do
        post :create, :activity => valid_attributes, :format => :json
        assigns(:activity).should be_a(Activity)
        assigns(:activity).should be_persisted
      end

      it "returns the json representation of the activity, and no errors" do
        post :create, :activity => valid_attributes, :format => :json
        JSON.parse(response.body)['errors'].should be_nil
      end

      it "should render the activity json response with 201 (created) code" do
        post :create, :activity => valid_attributes, :format => :json
        response.status.should == 201
        JSON.parse(response.body)['status'].should == "My Updated Status"
      end


    end

    describe "with a blank, invalid status" do

      it "does not assign an activity as @activity" do
        Activity.any_instance.stub(:save).and_return(false)
        post :create, {:activity => { "status" => "" }}, format: :json
        assigns(:activity).should be_nil
      end

      it "responds with status 406" do
        post :create, {:activity => { "status" => "" }}, format: :json
        response.status.should == 406
      end


    end
  end



end
