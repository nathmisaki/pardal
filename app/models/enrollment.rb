class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :course_semester
  belongs_to :situation, :class_name => "EnrollmentSituation"

  validates_presence_of :course_id

  def school_semester
    implementation = course.discipline.implementations.select { |implementation| implementation.curriculum == student.curriculum }
    if implementation
      implementation.first.school_semester
    else
      nil
    end
  end

  def self.proposal_for_student(student)
    student.curriculum.disciplines.map do |discipline|
      discipline.courses.map do |course|
        course.course_semesters do |course_semester|
          Enrollment.new(:course_semester_id => course_semester.id)
        end
      end
    end.flatten
  end
end
