require 'rails/response_injections'

ActionController::Base.send :include, Rails::ResponseInjections
