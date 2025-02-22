require "mailgun-ruby"

class MailgunService
  def self.send_email(to, subject, body)
    mg_client = Mailgun::Client.new(ENV["MAILGUN_API_KEY"]) # Store API key in ENV

    message_params = {
      from: ENV["MAILGUN_SENDER"],
      to: to,
      subject: subject,
      text: body
    }

    mg_client.send_message(ENV["MAILGUN_DOMAIN"], message_params)
  end
end
