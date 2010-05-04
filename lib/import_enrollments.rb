class ImportEnrollments < ImportClass

  def initialize
    @old_table_class = LegacyHistory
    @new_table_class = Enrollment
    super
  end

  def parse
    @rows = Array.new

    #caching some variables
    students = Student.all(:conditions => { :registration => @legacy_rows.map { |lr| lr.NumeroDeMatricula }.uniq })
    disciplines = Discipline.find_all_by_id(@legacy_rows.map { |lr| lr.CodigoDaDisciplina }.uniq)

    @legacy_rows.each do |reg|
      hash = Hash.new
      student = students.select { |s| s.registration == reg.NumeroDeMatricula }
      case student.size
      when 0
        logger.error("Nao foi encontrado o aluno => #{reg.NumeroDeMatricula}")
      when 1
        student = student.first
        discipline = disciplines.find { |d| d.id == reg.CodigoDaDisciplina.to_i }
        if discipline
          courses = discipline.courses.find_all_by_course_school_id(reg[:CodigoDaTurma]) if reg.CodigoDaTurma
          courses ||= discipline.courses_from_curriculum(student.curriculum)
          if courses.empty?
            logger.error("Nao foram encontradas turmas da disciplina #{reg.CodigoDaDisciplina} para o curriculum #{student.curriculum.inspect}, pegando qualquer uma.")
            courses = discipline.courses
            if courses.empty?
              course_school = student.curriculum.course_schools.first
              courses << discipline.courses.create(:course_school_id => course_school.id)
              logger.error("Criada turma #{courses.inspect} para a disciplina #{reg.CodigoDaDisciplina}.")
            end
          end
          course_semester = courses.first.course_semesters.find_or_create_by_semester(reg.SemestreEAno)
          hash[:student_id] = student.id
          hash[:course_semester_id] = course_semester.id
          hash[:grade] = reg[:Conceito]
          hash[:situation_id] = reg[:SituacaoDaMatricula]
          @rows << hash
        else
          logger.error("Não foi encontrado a disciplina => #{reg.CodigoDaDisciplina}")
        end
      else
        logger.error("Foi encotrado mais de um aluno #{student.inspect}")
      end
    end
    @legacy_rows = nil
  end

end
