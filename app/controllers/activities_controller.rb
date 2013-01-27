class ActivitiesController < ApplicationController

  before_filter :authenticate_user!, :only => [:create, :new, :latest_followed]

  # GET /activities
  # Returns activities for given user_id
  # @urlparam user_id (required)
  def index
    @user = User.where(id: params[:user_id]).first
    if @user.nil?
      @errors = "Invalid user"
    else
      @activities = @user.activities
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  #GET /activities/latest_followed
  def latest_followed
    followed = current_user.follows.map(&:id)
    since = 2.days.ago #TODO: configurable
    t = Activity.arel_table
    @activities = Activity.where(t[:user_id].in(followed).and(t[:updated_at].gteq(since)))
    render :action => 'index'
  end

  # GET /activities/1
  def show
    @activity = Activity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/new
  def new
    @activity = current_user.activities.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /activities/1/edit
  def edit
    @activity = Activity.find(params[:id])
  end

  # POST /activities
  def create

    @activity = current_user.activities.new(params[:activity])

    respond_to do |format|
      if params[:activity][:status].present?
        @activity = current_user.add_activity(params[:activity][:status])
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render json: @activity, status: :created, location: @activity }
      else
        format.html { render action: "new" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

 
end
