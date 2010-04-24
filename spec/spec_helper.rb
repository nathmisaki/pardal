ENV["RAILS_ENV"] ||= 'test'
require 'rubygems'
require 'spork'

Spork.prefork do
  require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
  require 'spec/autorun'
  require 'spec/rails'
  require 'webrat/integrations/rspec-rails'

  # Requires supporting files with custom matchers and macros, etc,
  # in ./support/ and its subdirectories.
  Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

  # Requires support classes to custom rake tasks
  Dir[File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib','*.rb'))].each{|f| require f}

  Spec::Runner.configure do |config|
    # If you're not using ActiveRecord you should remove these
    # lines, delete config/database.yml and disable :active_record
    # in your config/boot.rb
    config.use_transactional_fixtures = true
    config.use_instantiated_fixtures  = false
    config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
    config.before(:all)     { Sham.reset(:before_all)   }
    config.before(:each)    { Sham.reset(:before_each)  }
    config.before(:suite)   do
      if defined?(ActiveRecord::Base)
        begin
          require 'database_cleaner'
          DatabaseCleaner.strategy = :truncation
          DatabaseCleaner.clean
        rescue LoadError => ignore_if_database_cleaner_not_present
        end
      end
    end

  end

  class ActionController::TestCase
    include Devise::TestHelpers
  end
end

Spork.each_run do
  require File.expand_path(File.dirname(__FILE__) + "/blueprints")
end

# - These instructions should self-destruct in 10 seconds.  If they don't,
#   feel free to delete them.
#


