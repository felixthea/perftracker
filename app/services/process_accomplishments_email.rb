class ProcessAccomplishmentsEmail
  def initialize(email_params)
    @sender = email_params[:sender]
    @email_body = email_params["body-plain"]
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
    body = clean_body(@email_body)
    accomplishment = Accomplishment.create!(
      user: user,
      text: body, # Save email body as the accomplishment text
    )
    Rails.logger.info "Accomplishment saved for #{user.email}, accomplishment: #{accomplishment.id}"
  end

  private
  def clean_body(body)
    # Remove reply headers ("On ... wrote:" or variations)
    body = body.gsub(/On.*wrote:.*/m, "").strip
    body = body.gsub(/Am.*schreef:.*/m, "").strip
    body = body.gsub(/El.*escribió:.*/m, "").strip

    # Remove common signatures
    body = body.gsub(/^--.*/m, "").strip

    # Remove "Sent from my iPhone" type of lines
    body = body.gsub(/Sent from my .*/, "").strip

    body
  end
end
