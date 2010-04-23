require 'rubygems'
require 'active_record'
class Academnew < ActiveRecord::Base
  self.establish_connection(:academnew)
end
