class Activity < ActiveRecord::Base
  attr_accessible :status, :user_id
  validates :status, :presence => true

  belongs_to :user
end
