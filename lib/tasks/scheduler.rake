desc "This task creates weekly reviews for all users"
task generate_review_for_all_users: :environment do
  puts "generating review for all users"
  Services::AllReviewGenerator.new(
    start_time: DateTime.now - 7,
    end_time: DateTime.now,
    review_type: "WEEKLY"
  ).call
end

desc "This task sends a daily EOD email asking user for their accomplishments for the day"
task send_accomplishment_request_email: :environment do
  puts "sending accomplishment request email to all users"
  SendAccomplishmentRequestEmail.new().call
end
