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
                              disciplines.map{ |d| d.id }, student.curriculum.school_id, student.curriculum.period_id])
      courses = courses.group_by { |c| c.discipline_id }
      disciplines.map { |d| courses[d.id] }.flatten.compact
    end

    def enrollments_from_courses(courses)
      course_semesters = CourseSemester.all(:include => [:course => :discipline], :conditions => ["course_id IN (?) and semester = ?",
                                             courses.map{ |c| c.id }, (Time.now.year*10+(Time.now.month-1)/6+1)]).
                                             group_by { |cs| cs.course_id }
      enrollments = courses.map { |course|
        course_semesters[course.id].to_a.map { |course_semester|
          enrolls = student.enrollments.select { |e| e.course_semester == course_semester }
          if enrolls.blank?
            student.enrollments.build(:course_semester => course_semester)
          else
            enrolls.select { |e| !e.confirmed? }
          end
        }
      }.flatten
      enrollments
    end

    def logger
      ActiveRecord::Base.logger
    end

    def disciplines_without_concluded(disciplines)
      disciplines.reject { |d| student.discipline_concluded?(d.id) }
    end

end
