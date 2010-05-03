class Proposal
  attr_accessor :student

  def initialize(student)
    @student = student
  end

  def self.factory(student_model)
    idx = [student_model.curriculum.school_id, student_model.curriculum.period_id, student_model.curriculum.structure_code]
    begin
      eval("Proposals::School#{student_model.curriculum.school_id}").new(student_model)
    rescue NameError
      Proposal.new(student)
    end
  end

  def calculateEnrollments
    raise "calculateEnrollments should not be called in Proposal, propably you should include the proposals/school#{student.curriculum.school_id}.rb"
  end

  protected
    def courses_from_curriculum(disciplines)
      disciplines.map { |d| d.courses_from_curriculum(student.curriculum) }.flatten
    end

    def enrollments_from_courses(courses)
      courses.map { |course|
        course.current_course_semesters.map { |course_semester|
          student.enrollments.build(:course_semester => course_semester)
        }
      }.flatten
    end

    def disciplines_without_concluded(disciplines)
      disciplines.reject { |d| student.discipline_concluded?(d.id) }
    end

end
