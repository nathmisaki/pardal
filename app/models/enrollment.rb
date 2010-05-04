class Enrollment < ActiveRecord::Base
  belongs_to :student
  belongs_to :course_semester
  belongs_to :situation, :class_name => "EnrollmentSituation"

  validates_presence_of :course_semester_id, :student_id

  before_create :set_defaults_columns

  def self.proposal_for_student(student)
    Proposal.factory(student).calculateEnrollments
  end

  def school_semester
    implementation = course_semester.course.discipline.implementations.select { |implementation| implementation.curriculum == student.curriculum }
    unless implementation.empty?
      implementation.first.school_semester
    else
      nil
    end
  end

  def confirmed?
    !confirmed_at.nil?
  end

  def confirm!
    confirmed_at = Time.now
    save
  end

  def discipline
    course_semester.course.discipline
  end

  def course
    course_semester.course
  end

  private

  def validate
    # Enrollment isn't in proposal, so don't come from form, it's a form-hijack.
    errors.add_to_base("Não faz parte da proposta") unless
    Enrollment.proposal_for_student(student).map { |e|
        e.course_semester_id
      }.include?(course_semester_id)

    # Time conflict, there is another enrollment in the same time
    enrolls = student.enrollments.all(:include => [:course_semester => :course_schedules], :joins => [:course_semester], :conditions => ["course_semesters.semester = ?", course_semester.semester])
    enrolls.each do |enroll|
      enroll.course_semester.course_schedules.each { |schedule|
        course_semester.course_schedules.each { |schedule2|
          errors.add_to_base("Conflito de horário com #{enroll.discipline.acronym}-#{enroll.course.course_school_id} #{schedule.short} com a aula de #{schedule2.short}") if schedule.conflict_hours?(schedule2)
        }
      }
    end

  end

  def set_defaults_columns
    self.situation_id = 99
  end
end
