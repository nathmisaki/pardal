class CourseSemester < ActiveRecord::Base
  belongs_to :course
  has_many :course_schedules
end
