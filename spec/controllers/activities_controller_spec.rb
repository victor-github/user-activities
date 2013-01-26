require 'spec_helper'

describe ActivitiesController do

  def valid_attributes
    { "status" => "My Updated Status" }
  end


  def valid_session
    {}
  end

  describe "GET all activities for given user_id" do
    before(:each) do
      FactoryGirl.create(:user, :id => 2)
    end
    it "assigns all activities as @activities" do
      activity1 = FactoryGirl.create(:activity, :user_id => 2)
      activity2 = FactoryGirl.create(:activity, :user_id => 2)
      get :index, { :user_id => 2 }, valid_session
      assigns(:activities).should eq([activity1, activity2])
    end
  end

  describe "GET show" do
    it "assigns the requested activity as @activity" do
      activity = Activity.create! valid_attributes
      get :show, {:id => activity.to_param}, valid_session
      assigns(:activity).should eq(activity)
    end
  end

  describe "GET new" do
    login_first_user
    it "assigns a new activity as @activity" do
      get :new, {}, valid_session
      assigns(:activity).should be_a_new(Activity)
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
          post :create, {:activity => valid_attributes}, valid_session
        }.to change(Activity, :count).by(1)
      end

      it "assigns a newly created activity as @activity" do
        post :create, {:activity => valid_attributes}, valid_session
        assigns(:activity).should be_a(Activity)
        assigns(:activity).should be_persisted
      end

      it "redirects to the created activity" do
        post :create, {:activity => valid_attributes}, valid_session
        response.should redirect_to(Activity.last)
      end
    end

    describe "with a blank status" do

      it "assigns a newly created but unsaved activity as @activity" do
        Activity.any_instance.stub(:save).and_return(false)
        post :create, {:activity => { "status" => "" }}, valid_session
        assigns(:activity).should be_a_new(Activity)
      end

      it "re-renders the 'new' template" do
        Activity.any_instance.stub(:save).and_return(false)
        post :create, {:activity => { "status" => "" }}, valid_session
        response.should render_template("new")
      end
    end
  end



end
