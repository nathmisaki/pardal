class ImportEnrollments < ImportClass

  def initialize
    @old_table_class = LegacyHistory
    @new_table_class = Enrollment
    super
  end

  def parse
    @rows = Array.new
    @legacy_rows.each do |reg|
      hash = Hash.new
      student = Student.find_all_by_registration reg.NumeroDeMatricula
      case student.size
      when 0
        logger.error("Nao foi encontrado o aluno => #{reg.NumeroDeMatricula}")
      when 1
        student = student.first
        courses = Discipline.find(reg.CodigoDaDisciplina).courses.find(reg[:CodigoDaTurma]) if reg.CodigoDaTurma
        courses ||= Discipline.find(reg.CodigoDaDisciplina).courses_from_curriculum(student.curriculum)
        if courses.size == 0
          logger.error("Nao foram encontradas turmas para o aluno #{reg.inspect}")
        else
          course_semester = courses.first.course_semesters.find_or_create_by_semester(reg.SemestreEAno)
        end
      else
        logger.error("Foi encotrado mais de um aluno #{student.inspect}")
      end
      hash[:student_id] = student.id
      hash[:course_semester_id] = course_semester.id
      hash[:grade] = reg[:Conceito]
      hash[:situation_id] = reg[:SituacaoDaMatricula]
      @rows << hash
    end
    @legacy_rows = nil
  end

end
