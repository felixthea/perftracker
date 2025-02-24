class MailgunController < ApplicationController
  skip_before_action :verify_authenticity_token # Webhooks don’t use CSRF protection

  def incoming
    # Parse the Mailgun JSON payload
    Rails.logger.info ("Email params from line 6=#{params}")
    email_params = params.permit(:recipient, :sender, :subject, :body_plain)

    # Log for debugging (optional)
    Rails.logger.info "Received email from #{email_params[:sender]} to #{email_params[:recipient]}"

    ProcessAccomplishmentsEmail.new(params.permit(:sender, :recipient, :subject, :body_plain)).call

    # Respond to Mailgun to acknowledge receipt
    render json: { status: "success" }, status: 200
  end
end
