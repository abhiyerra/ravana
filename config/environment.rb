# Load the rails application
require File.expand_path('../application', __FILE__)

$CONFIG = YAML::load(File.join(Rails.root, 'config', 'ravana.yml'))

# Initialize the rails application
Tradings::Application.initialize!
