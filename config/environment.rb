# Load the Rails application.
require File.expand_path('../application', __FILE__)

#load environment variables
app_environment_variables = File.join(Rails.root, 'config', 'app_env_vars.rb')
load(app_environment_variables) if File.exists?(app_environment_variables)

# Initialize the Rails application.
Rails.application.initialize!
