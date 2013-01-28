class ActivitiesController < ApplicationController

  before_filter :authenticate_user!, :only => [:create, :new, :latest_followed]

  # GET /activities
  # Gets activities for given user_id, if specified, or all activities from followed users otherwise 
  # @urlparam user_id (optional)
  def index
    @user = User.where(id: params[:user_id]).first
    if @user.nil?
      redirect_to '/activities/latest_followed'
      return
    else
      @activities = @user.activities
    end

    respond_to do |format|
      format.html { render :action => 'latest_followed'}
    end
  end

  #GET /activities/latest_followed
  #Gets all activities from followed users
  def latest_followed
    followed = current_user.follows.map(&:id)
    since = SINCE 
    t = Activity.arel_table
    @activities = Activity.where(t[:user_id].in(followed).and(t[:updated_at].gteq(since)).or(t[:user_id].eq(current_user.id))).order("updated_at desc")
  end

  # GET /activities/1
  def show
    @activity = Activity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  # POST /activities.json
  def create
    respond_to do |format|
      if params[:activity][:status].present?
        @activity = current_user.add_activity(params[:activity][:status])
        format.json { render json: @activity, status: :created, location: @activity }
      else
        format.json { render json: {errors: "Invalid status"}, status: :unprocessable_entity }
      end
    end
  end
 
end
