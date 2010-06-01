class Course < ActiveRecord::Base
  belongs_to :discipline
  belongs_to :course_school
  has_many :course_semesters

  def current_course_semester
    course_semesters.find_by_semester Time.now.year_semester
  end
end
