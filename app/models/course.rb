class Course < ActiveRecord::Base
  belongs_to :discipline
  belongs_to :course_school
  has_many :course_semesters
end
