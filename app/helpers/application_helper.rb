module ApplicationHelper
  def display_datetime(datetime)
    datetime.in_time_zone(Rails.application.config.time_zone).to_time.to_s(:my_time_format)
  end
end
