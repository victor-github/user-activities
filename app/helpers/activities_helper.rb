module ActivitiesHelper
  def activity_page_title
    @user.present? ? "Updates for #{@user.nickname}" : "Your Wall - Latest Updates"
  end
  
  def activity_user_name(a)
    a.user == current_user ? "you" : a.user.nickname
  end
end
