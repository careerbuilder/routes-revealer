$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'routes_revealer/version'
#
# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'routes_revealer'
  s.version     = RoutesRevealer::VERSION
  s.authors     = 'The CareerBuilder.com Consumer Development teams'
  s.email       = 'opensource@careerbuilder.com'
  s.homepage    = 'https://github.com/careerbuilder/routes-revealer'
  s.summary     = 'Provides the route /routes which will list the applications routes'
  s.description = 'The /routes route will list all of the consuming application\'s routes except for external redirects, generic HTTP status pages, and default Rails routes'
  s.license     = 'Apache-2.0'

  s.files = Dir["{app,config,db,lib,vendor}/**/*", 'LICENSE', 'Rakefile']
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'rails', '> 4.0.0'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'binding_of_caller'
  s.add_development_dependency 'better_errors', '~> 1.1'
  s.add_development_dependency 'codeclimate-test-reporter'
  s.add_development_dependency 'webmock', '~> 1.21'
  s.add_development_dependency 'simplecov', '~> 0.7', '>= 0.7.1'
end
