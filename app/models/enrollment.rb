class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :course_semester
  belongs_to :situation, :class_name => "EnrollmentSituation"

  validates_presence_of :course_semester_id

  def school_semester
    implementation = course_semester.course.discipline.implementations.select { |implementation| implementation.curriculum == student.curriculum }
    unless implementation.empty?
      implementation.first.school_semester
    else
      nil
    end
  end

  def self.proposal_for_student(student)
    Proposal.factory(student).calculateEnrollments
  end
end
