require 'rubygems'
require File.join(File.dirname(__FILE__), '../..', 'config', 'environment')
Dir.glob(File.join(File.dirname(__FILE__), '..', '*.rb')).sort.each {|f| require f}
