class Course < ActiveRecord::Base
  belongs_to :discipline
  belongs_to :course_school
  has_many :course_semesters

  def current_course_semester
    semester = Time.now.year*10 + (Time.now.month-1)/6 + 1
    course_semesters.find_by_semester semester
  end
end
