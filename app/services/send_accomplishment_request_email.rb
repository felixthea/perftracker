class SendAccomplishmentRequestEmail
  ACCOMPLISHMENT_REQUEST_EMAIL_BODY = "Hi, please tell me what you did today in the STAR format!"
  SEND_HOUR = 16 # 16 represents 4 PM
  def initialize
  end

  def call
    send_for_all_users
  end

  def send_for_all_users
    User.all.each do |user|
      time_in_user_tz = Time.current.in_time_zone(user.timezone)

      # Only send if within SEND_HOUR and is during a weekday
      if time_in_user_tz.hour == SEND_HOUR && (1..5).cover?(time_in_user_tz.wday)
        MailgunService.send_email(user.email, "What did you do today?", ACCOMPLISHMENT_REQUEST_EMAIL_BODY)
      end
    end
  end
end
