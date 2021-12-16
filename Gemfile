# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'active_storage_validations'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'colorize'
gem 'image_processing', '~> 1.2'
gem 'multi_schema'
gem 'mutils'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.5'
gem 'rack-cors'
gem 'rails', '~> 7.0.0'
gem 'redis', '~> 4.5'
group :development, :test do
  gem 'annotate'
  gem 'brakeman'
  gem 'bundler-audit'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails', require: 'dotenv/rails-now'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'rails-erd'
  gem 'rspec-rails'
  gem 'rubocop-rails'
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'shoulda-matchers', require: false
  gem 'simplecov', require: false
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
