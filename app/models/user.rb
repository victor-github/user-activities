class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :activities

  has_and_belongs_to_many :followed, :class_name => User, :join_table => :followings, :foreign_key => :follower_user_id, :association_foreign_key => :followed_user_id
  has_and_belongs_to_many :followers, :class_name => User, :join_table => :followings, :foreign_key => :followed_user_id, :association_foreign_key => :follower_user_id
end
