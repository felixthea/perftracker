desc "This task creates weekly reviews for all users"
task :generate_review_for_all_users, [ :skip_time_restriction ] => :environment do |task, args|
  puts "generating review for all users"
  AllReviewGenerator.new(
    start_time: DateTime.now - 7,
    end_time: DateTime.now,
    review_type: "WEEKLY",
    skip_time_restriction: skip_time_restriction
  ).call
end

desc "This task sends a daily EOD email asking user for their accomplishments for the day"
task send_accomplishment_request_email: :environment do
  puts "sending accomplishment request email to all users"
  SendAccomplishmentRequestEmail.new().call
end
