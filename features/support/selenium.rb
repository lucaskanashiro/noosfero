require 'database_cleaner'
require 'database_cleaner/cucumber'

Cucumber::Rails::World.use_transactional_fixtures = false

Capybara.default_driver = :selenium
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

# FIXME: 'DELETE FROM ...' is being ran 3x - see cucumber.log
DatabaseCleaner.clean_with :truncation
DatabaseCleaner.strategy = :truncation

Before do
  DatabaseCleaner.start
end

After do
  DatabaseCleaner.clean
end

World(Capybara)
