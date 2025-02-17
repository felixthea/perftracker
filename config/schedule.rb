set :environment, 'production'

# Set the output path for logging
set :output, "log/cron_log.log"

# Define the cron job to run once a week (e.g., every Monday at 8:00 am)
every :friday, at: '7:00 pm' do
  # Use the Ruby command to call the ReviewGenerator service object
  runner "ReviewGenerator.call"
end