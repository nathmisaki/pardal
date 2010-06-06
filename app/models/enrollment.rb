# Enrollment significa Matrícula em inglês.
# Este modelo é a representação da matrícula do aluno nos cursos da faculdade.
#
# == Atributos
#
# - :student[_id] (integer)         => Associação ao modelo Student
# - :course_semester[_id] (integer) => Associação ao modelo CourseSemester
# - :grade ([A,B,C,D,E,F,G,T])      => Conceito do aluno ao concluir o Enrollment
# - :situation[_id] (integer)       => Associação ao modelo EnrollmentSituation
# - :confirmed_at (datetime)        => Data e hora da confirmação da matrícula
class Enrollment < ActiveRecord::Base
  include Comparable
  belongs_to :student
  belongs_to :course_semester
  belongs_to :situation, :class_name => "EnrollmentSituation"

  attr_accessor :validate_proposal

  validates_presence_of :course_semester_id, :student_id

  before_create :set_defaults_columns

  ########################################################################
  ### N A M E D   S C O P E S
  ########################################################################

  named_scope :for_history, :from => 'enrollments_for_history'

  named_scope :course_semesters_in, lambda { |*course_semesters|
    course_semesters.flatten!
    course_semesters.map!(&:id) if course_semesters.first.is_a?(CourseSemester)
    { :conditions => { :course_semester_id => course_semesters } }
  }

  named_scope :semester_eql, lambda { |semester|
    {
      :joins => :course_semester,
      :conditions => ['course_semesters.semester = ?', semester ]
    }
  }

  named_scope :student_eql, lambda { |student_id|
    { :conditions => ['student_id = ?', student_id] }
  }

  named_scope :including_schedules, :include => [:course_semester => :course_schedules]

  ########################################################################
  ### P U B L I C   C L A S S   M E T H O D S
  ########################################################################

  def self.proposal_for_student(student)
    Proposal.factory(student).calculateEnrollments
  end

  ########################################################################
  ### P U B L I C   I N S T A N C E   M E T H O D S
  ########################################################################

  def <=>(other)
    return nil unless other.is_a?(Enrollment)
    (other.semester <=> self.semester).nonzero? ||
    (self.school_semester <=> other.school_semester).nonzero? ||
    (self.discipline_code <=> other.discipline_code).nonzero? ||
    0
  end

  def ==(other)
    self.attributes == other.attributes
  end

  def school_semester
    school_sem = read_attribute(:school_semester)
    unless school_sem
      implementation = course_semester.course.discipline.implementations.first :conditions => { :curriculum_id => student.curriculum.id }
      school_sem = implementation.school_semester unless implementation.blank?
    end
    school_sem.to_i
  end

  def discipline_code
    disc_code = read_attribute(:discipline_code)
    disc_code ||= course_semester.course.discipline.code
    disc_code.to_i
  end

  def discipline_name
    disc_name = read_attribute(:discipline_name)
    disc_name ||= course_semester.course.discipline.name
    disc_name.to_s
  end

  def semester
    sem = read_attribute(:semester)
    sem ||= course_semester.semester
    sem.to_i
  end

  def confirmed?
    !confirmed_at.nil?
  end

  def confirm!
    self.confirmed_at = Time.now
    self.save
  end

  def discipline
    course_semester.course.discipline
  end

  def course
    course_semester.course
  end

  def status
    if errors.empty?
      if situation.nil?
        "incomplete"
      else
        if situation.active
          "valid"
        else
          if situation.description =~ /Aguardando/i
            "waiting"
          else
            "invalid"
          end
        end
      end
    else
      "invalid"
    end
  end

  ########################################################################
  ### P R I V A T E   M E T H O D S
  ########################################################################

  private

  def validate #:doc:
    if validate_proposal
      # Enrollment isn't in proposal, so don't come from form, it's a form-hijack.
      course_semester_ids = Enrollment.proposal_for_student(student).map do |e|
        e.course_semester_id
      end

      errors.add_to_base("Não faz parte da proposta") unless
      course_semester_ids.include?(course_semester_id)
    end

    # Time conflict, there is another enrollment in the same time
    enrolls = student.enrollments.semester_eql(course_semester.semester).including_schedules
    enrolls.each do |enroll|
      enroll.course_semester.course_schedules.each { |schedule|
        course_semester.course_schedules.each { |schedule2|
          errors.add_to_base("Conflito de horário com #{enroll.discipline.acronym}-#{enroll.course.course_school_id} #{schedule.short} com a aula de #{schedule2.short}") if schedule.conflict_hours?(schedule2)
        }
      }
    end

  end

  def set_defaults_columns #:doc:
    self.situation_id = 99
  end
end
