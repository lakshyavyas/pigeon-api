# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'simplecov'
SimpleCov.start 'rails' unless ENV['NO_COVERAGE']

require 'spec_helper'
require 'shoulda-matchers'
require 'active_storage_validations/matchers'
require_relative './support/factory_bot'
require_relative './support/shared_functions'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include SharedFunctions
  config.include ActiveStorageValidations::Matchers
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
