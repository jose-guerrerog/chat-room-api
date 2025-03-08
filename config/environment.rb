# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

puts "Available routes:"
Rails.application.routes.routes.each do |route|
  puts "  #{route.path.spec}"
end