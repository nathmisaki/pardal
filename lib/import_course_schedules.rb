class ImportCourseSchedules < ImportClass

  def initialize
    @old_table_class = LegacyCourseSchedule
    @new_table_class = CourseSchedule
    super
  end

  def parse
    @rows = Array.new
    courses = Course.all(:conditions => { :discipline_id => @legacy_rows.map(&:CodigoDaDisciplina),
                         :course_school_id => @legacy_rows.map(&:CodigoDaTurma) })
    @legacy_rows.each do |reg|
      hash = Hash.new
      course = courses.find { |c|
        c.discipline_id == reg[:CodigoDaDisciplina].to_i and
        c.course_school_id == reg[:CodigoDaTurma].to_i
      }
      course.course_semesters.each do |cs|
        hash[:course_semester_id] = cs.id
        hash[:weekday] = reg[:DiaDaAula]
        hash[:start_hour] = reg[:HorarioDeInicioDaAula]
        hash[:end_hour] = reg[:HorarioDeTerminoDaAula]
        @rows << hash
      end
    end
    @legacy_rows = nil
  end

end
