Project showcasing twitter-like functionality where users can post statuses (activities) and follow other users.

Uses Rails 3, RSpec 2 and Devise.



Functions:

* create an activity (for current_user) POST /activities/create {status: "status"}
* "follow" a particular user POST /users/follow {user_id: 2}
* "unfollow" POST /users/unfollow {user_id: 2}
* see all activities for given user GET /activities?user_id=2
* see all recent activities for followed users GET /activities/latest_followed
