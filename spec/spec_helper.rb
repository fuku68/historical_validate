require "rails/all"
require 'bundler/setup'
require 'historical_validate'
require 'rspec/rails'
require 'ammeter/init'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
  load File.dirname(__FILE__) + '/schema.rb'
  require File.dirname(__FILE__) + '/models/user.rb'
end
