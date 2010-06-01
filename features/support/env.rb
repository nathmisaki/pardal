require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= "cucumber"
  require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')

  require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support
  require 'cucumber/rails/world'
  require 'cucumber/rails/active_record'
  require 'cucumber/web/tableish'

  require 'webrat'
  require 'webrat/core/matchers'
end

Spork.each_run do
  require File.expand_path(File.dirname(__FILE__) + '/../../spec/spec_helper')

  if defined?(ActiveRecord::Base)
    begin
      require 'database_cleaner'
      DatabaseCleaner.strategy = :truncation, {:except => %w[enrollments_for_history]} 
      DatabaseCleaner.clean
    rescue LoadError => ignore_if_database_cleaner_not_present
    end
  end
end

# - These instructions should self-destruct in 10 seconds.  If they don't,
#   feel free to delete them.
#

