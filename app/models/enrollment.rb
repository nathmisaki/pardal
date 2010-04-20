class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :course
  belongs_to :situation, :class_name => "EnrollmentSituation"

  def school_semester
    implementation = course.discipline.implementations.select { |implementation| implementation.curriculum == student.curriculum }
    if implementation
      implementation.first.school_semester
    else
      nil
    end
  end
end
