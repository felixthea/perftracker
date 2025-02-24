class MailgunController < ApplicationController
  skip_before_action :verify_authenticity_token # Webhooks don’t use CSRF protection

  def incoming
    Rails.logger.info "Received email from #{params[:sender]} to #{params[:recipient]}"

    ProcessAccomplishmentsEmail.new(params).call

    # Respond to Mailgun to acknowledge receipt
    render json: { status: "success" }, status: 200
  end
end
