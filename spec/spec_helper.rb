ENV['RAILS_ENV'] ||= 'test'
require 'pry'

require File.expand_path("../../test/dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')
Dir[File.expand_path('../support/**/*.rb', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.include RSpec::Rails::RailsExampleGroup
  config.expose_current_running_example_as :example
  config.infer_spec_type_from_file_location!
  config.infer_base_class_for_anonymous_controllers = false

  config.include ControllerHelpers, type: :controller
end
