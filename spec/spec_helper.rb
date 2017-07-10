# Copyright 2017 CareerBuilder, LLC
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.
require 'simplecov'
require 'codeclimate-test-reporter'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow: 'codeclimate.com')

SimpleCov.start do
  at_exit do
    SimpleCov::Formatter::HTMLFormatter.new.format(SimpleCov.result)
  end
end

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
