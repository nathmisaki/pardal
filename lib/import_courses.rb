class ImportCourses < ImportClass

  def initialize
    @old_table_class = LegacyCourse
    @new_table_class = Course
    super
  end

  def parse
    @rows = Array.new
    @legacy_rows.each do |reg|
      hash = Hash.new
      hash[:discipline_id] = reg[:CodigoDaDisciplina].to_i
      hash[:course_school_id] = reg[:CodigoDaTurma].to_i
      hash[:has_grade_list] = reg[:EmiteListaDeConceitos].to_i
      hash[:grade_list_qty] = reg[:QuantidadeDeListas].to_i
      hash[:divide_class] = reg[:DivideTurmas].to_i
      @rows << hash
    end
    @legacy_rows = nil
  end

end
