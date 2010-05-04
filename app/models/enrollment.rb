class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :course_semester
  belongs_to :situation, :class_name => "EnrollmentSituation"

  validates_presence_of :course_semester_id, :student_id

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

  private

  def validate
    # Enrollment isn't in proposal, so don't come from form.
    errors.add_to_base("Não faz parte da proposta") unless
    Enrollment.proposal_for_student(student).map { |e|
        e.course_semester_id
      }.include?(course_semester_id)
  end
end
