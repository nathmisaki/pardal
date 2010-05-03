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
      courses = Course.all(:joins => [:course_school],
                            :conditions => ["discipline_id IN (?) and (course_schools.school_id = ? and course_schools.period_id = ?)",
                              disciplines.map(&:id), student.curriculum.school_id, student.curriculum.period_id])
      courses.group_by { |c| c.discipline_id }
      disciplines.map { |d| courses[d.id] }.flatten
    end

    def enrollments_from_courses(courses)
      course_semesters = CourseSemester.all(:conditions => ["course_id IN (?) and semester = ?",
                                             courses.map(&:id), (Time.now.year*10+(Time.now.month-1)/6+1)])
      course_semesters.group_by { |cs| cs.course_id }
      courses.map { |course|
        course_semesters[course.id].map { |course_semester|
          student.enrollments.build(:course_semester => course_semester)
        }
      }.flatten
    end

    def disciplines_without_concluded(disciplines)
      disciplines.reject { |d| student.discipline_concluded?(d.id) }
    end

    def logger
      ActiveRecord::Base.logger
    end

end
