module UsersHelper
  def follow_link(u)
    if current_user.follows?(u)
      button_tag "Unfollow", :type => "button", :class => "unfollow_user_button", :id=> "user_button_#{u.id}"
    else
      button_tag "Follow", :type => "button", :class => "follow_user_button", :id=> "user_button_#{u.id}"
    end
  end
end
