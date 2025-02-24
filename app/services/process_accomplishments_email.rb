class ProcessAccomplishmentsEmail
  def initialize(email_params)
    @sender = email_params[:sender]
    @email_body = email_params[:body_plain]
  end

  def call
    user = find_user_by_email
    return unless user

    create_accomplishment(user)
  end

  private
  def find_user_by_email
    User.find_by(email: @sender) # Ensure sender exists as a user
  end

  def create_accomplishment(user)
    accomplishment = Accomplishment.create!(
      user: user,
      text: @email_body.strip, # Save email body as the accomplishment text
    )
    Rails.logger.info "Accomplishment saved for #{user.email}, accomplishment: #{accomplishment.id}"
  end
end
