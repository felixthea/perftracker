class MailgunController < ApplicationController
  skip_before_action :verify_authenticity_token # Webhooks don’t use CSRF protection

  def incoming
    Rails.logger.info "Received email from #{params[:sender]} to #{params[:recipient]}"

    accomplishment = ProcessAccomplishmentsEmail.new(params).call

    Rails.logger.info "Accomplishment saved! accomplishment: #{accomplishment.id}"

    user = User.find_by(email: params[:sender])
    immediate_feedback_prompt = "Hi, I would like you to create a recap of my day with these accomplishment(s)
      and how they helped me meet or exceed my expectations. Write this in a
      way where you are talking directly to me to give me mostly positive feedback. Start directly with the feedback, without
      any introductory phrases or acknowledgements of this request."
    prompt_str = immediate_feedback_prompt.dup
    accomplishments_str = "Here are my accomplishments for today:\n"
    accomplishments_str << accomplishment.text

    most_recent_expectation = Expectation.where(user_id: user.id).order(created_at: :desc).first
    expectation_str = "\nAnd here is the job expectation:\n#{most_recent_expectation.text}"

    prompt_str << accomplishments_str
    prompt_str << expectation_str

    review_generator = ReviewGenerator.new(
      user_id: user.id,
      start_time: DateTime.now,
      end_time: DateTime.now,
      expectation_id: most_recent_expectation.id,
      review_type: "immediate_feedback",
      initial_prompt: prompt_str,
      accomplishments: accomplishments
    )

    review = review_generator.call

    Rails.logger.info "Review completed review_type=immediate_feedback, review:#{review.id}:, accomplishment:#{accomplishment.id}"

    if !review.nil?
      MailgunService.send_email(user.email, params[:subject], review.result)
    end

    # Respond to Mailgun to acknowledge receipt
    render json: { status: "success" }, status: 200
  end
end
