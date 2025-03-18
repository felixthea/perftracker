class AllReviewGenerator
  OPENAI_URL = "https://api.openai.com/v1/chat/completions"
  SEND_HOUR = 18 # 6pm

  def initialize(start_time:, end_time:, review_type:, skip_time_restriction: false)
    @start_time = start_time
    @end_time = end_time
    @review_type = review_type
    @skip_time_restriction = skip_time_restriction

    @initial_prompt = case @review_type
    when "WEEKLY"
      Prompts::WEEKLY_PROMPT
    when "SELF_REVIEW"
      Prompts::DEFAULT_PROMPT
    end
  end

  def call
    generate_report_for_all_users
  end

  def generate_report_for_all_users
    User.all.each do |user|
      time_in_user_tz = Time.current.in_time_zone(user.timezone)

      # Only send this report if it's Friday at 6pm the user's timezone or if we are skipping the time restriction
      if @skip_time_restriction || (time_in_user_tz.hour == SEND_HOUR && time_in_user_tz.wday == 5)
        # In the future we may ask the user to specify which expectation to use
        most_recent_expectation = Expectation.where(user_id: user.id).order(created_at: :desc).first
        review_generator = ReviewGenerator.new(
          user_id: user.id,
          start_time: @start_time,
          end_time: @end_time,
          expectation_id: most_recent_expectation.id,
          review_type: @review_type,
          initial_prompt: @initial_prompt
        )

        review = review_generator.call

        if !review.nil?
          MailgunService.send_email("felix@easyperf.co", "Your EasyPerf report!", review.result)
        end
      end
    end
  end
end
