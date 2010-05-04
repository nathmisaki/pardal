class ImportCourseSchedules < ImportClass

  HORARIOS = {
    1 => Time.parse("7:30"),
    2 => Time.parse("8:25"),
    3 => Time.parse("9:20"),
    4 => Time.parse("10:15"),
    5 => Time.parse("11:10"),
    6 => Time.parse("12:05"),
    7 => Time.parse("13:00"),
    8 => Time.parse("13:55"),
    9 => Time.parse("14:50"),
    10 => Time.parse("15:45"),
    11 => Time.parse("16:40"),
    12 => Time.parse("17:35"),
    13 => Time.parse("18:20"),
    14 => Time.parse("19:00"),
    15 => Time.parse("19:55"),
    16 => Time.parse("20:50"),
    17 => Time.parse("21:45"),
    18 => Time.parse("22:40"),
    19 => Time.parse("23:30")
  }

  def initialize
    @old_table_class = LegacyCourseSchedule
    @new_table_class = CourseSchedule
    super
  end

  def parse
    @rows = Array.new
    @legacy_rows.each do |reg|
      course = Course.first(:conditions => { :discipline_id => reg[:CodigoDaDisciplina].to_i, :course_school_id => reg[:CodigoDaTurma] })
      unless course
        logger.debug("Não foi encontrado a turma #{reg[:CodigoDaDisciplina]}-#{reg[:CodigoDaTurma]}")
      else
        course.course_semesters.each do |cs|
          cs.course_schedules.create(
            :weekday => reg[:DiaDaAula].to_i,
            :start_hour => HORARIOS[reg[:HorarioDeInicioDaAula].to_i],
            :end_hour => HORARIOS[reg[:HorarioDeTerminoDaAula].to_i])
        end
      end
    end
    @legacy_rows = nil
  end

end
