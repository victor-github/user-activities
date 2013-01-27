class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :activities

  has_and_belongs_to_many :follows, :class_name => User, :join_table => :followings, :foreign_key => :follower_user_id, :association_foreign_key => :followed_user_id
  has_and_belongs_to_many :followers, :class_name => User, :join_table => :followings, :foreign_key => :followed_user_id, :association_foreign_key => :follower_user_id

  def follow(user)
    return false unless user != self 
    self.follows << user
    self.save!
  end

  def follows?(user)
    self.follows.include?(user)
  end

  def add_activity(status)
    self.activities.create(:status => status)
  end

  def nickname
    self.email[/[^@]+/]
  end

end
