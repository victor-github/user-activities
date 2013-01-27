module ActivitiesHelper
  def activity_page_title
    if @user.present?
      "Activities for #{@user.nickname}"
    else
      "Latest updates"
    end
  end
end
