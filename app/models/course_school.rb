class CourseSchool < ActiveRecord::Base
  belongs_to :period
  belongs_to :school
end
