desc "This task is called by the Heroku scheduler add-on"
task update_feed: :environment do
  puts "Updating feed..."
  puts "done."
end

desc "This task creates weekly reviews for all users"
task generate_review_for_all_users: :environment do
  puts "generating review for all users"
  AllReviewGenerator.new(
    start_time: DateTime.now - 7,
    end_time: DateTime.now,
    review_type: "WEEKLY"
  ).call
end
