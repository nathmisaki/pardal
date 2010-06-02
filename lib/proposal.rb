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
      Proposal.new(student_model)
    end
  end

  def calculateEnrollments
    raise "calculateEnrollments should not be called in Proposal, "\
    +"propably you should include the proposals/school"
    +"#{student.curriculum.school_id}.rb"
  end

  ########################################################################
  ### P R O T E C T E D   M E T H O D S
  ########################################################################

  protected
    def courses_from_curriculum(disciplines)
      courses = disciplines.map{ |discipline| discipline.courses_from_curriculum(student.curriculum) }
      courses.flatten!
      courses = courses.group_by { |c| c.discipline_id }
      disciplines.map { |d| courses[d.id] }.flatten.compact
    end

    def disciplines_with_prerrequisites_concluded(disciplines)
      disciplines
    end

    def enrollments_from_courses(courses)
      course_semesters = CourseSemester.courses_in(courses).only_current_semester.including_course_and_discipline
      course_semesters = course_semesters.group_by { |cs| cs.course_id }

      enrollments = courses.map do |course|
        course_semesters[course.id].to_a.map do |course_semester|
          enrolls = student.enrollments.course_semesters_in(course_semester)
          if enrolls.blank?
            Enrollment.new(:course_semester => course_semester, :student => student)
          else
            enrolls.select { |e| !e.confirmed? }
          end
        end
      end
      enrollments.flatten
    end

    def logger
      ActiveRecord::Base.logger
    end

    def disciplines_without_concluded(disciplines)
      disciplines.reject { |d| student.discipline_concluded?(d.id) }
    end

end
