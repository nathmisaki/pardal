# == Schema Information
#
# Table name: course_schools
#
#  id         :integer(4)      not null, primary key
#  period_id  :integer(4)
#  school_id  :integer(4)
#  code       :integer(4)
#  symbol     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class CourseSchool < ActiveRecord::Base
  belongs_to :period
  belongs_to :school
end
