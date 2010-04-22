class ImportCourseSchools < ImportClass

  def initialize
    @old_table_class = LegacyCourseSchool
    @new_table_class = CourseSchool
    super
  end

  def parse
    @rows = Array.new
    @legacy_rows.each do |reg|
      
      hash = Hash.new
      hash[:id] = reg[:CodigoDaTurma].to_i
      hash[:code] = reg[:CodigoDaTurma].to_i
      hash[:school_id] = reg[:CodigoDoCurso].to_i
      hash[:period_id] = reg[:CodigoDoTurno].to_i
      hash[:symbol] = reg[:SiglaDaTurma]
      @rows << hash
    end
    @legacy_rows = nil
  end

end
