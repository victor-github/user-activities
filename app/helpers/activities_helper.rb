module ActivitiesHelper
  def activity_page_title
    @user.present? ? "Activities for #{@user.nickname}" : "Latest updates"
  end
end
