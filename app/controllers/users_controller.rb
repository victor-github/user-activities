class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:follow, :unfollow, :create, :update, :edit, :new]

  def index
    @users = User.all
  end

  #/users/follow
  #@param user_id (required) - user to unfollow
  def follow
    u = User.where(id: params[:user_id]).first
    if u.present?
      current_user.follow(u)
    else
      errors = "No Such User"
    end
    respond_to do |format|
      if errors.nil?
        format.json { render json: u }
      else
        format.json { render json: { errors: errors } }
      end
    end
  end

  def unfollow
    u = User.where(id: params[:user_id]).first
    if u.present?
      current_user.unfollow(u)
    else
      errors = "No Such User"
    end
    respond_to do |format|
      if errors.nil?
        format.json { render json: u }
      else
        format.json { render json: { errors: errors } }
      end
    end
  end

end
