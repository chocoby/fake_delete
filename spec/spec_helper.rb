require 'fake_delete'
require 'active_record'
require 'sqlite3'
require 'database_cleaner'
require 'awesome_print'

support_path = Pathname.new File.expand_path('../spec/support', File.dirname(__FILE__))

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

load "#{support_path}/schema.rb"

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
