# == Schema Information
#
# Table name: school_areas
#
#  id         :integer(4)      not null, primary key
#  name       :string(200)
#  created_at :datetime
#  updated_at :datetime
#

class SchoolArea < ActiveRecord::Base
  has_many :schools
end
