class Followings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.integer :follower_user_id
      t.integer :followed_user_id
    end
  end
end
