class ImportSchools < ImportClass

  def initialize
    @old_table_class = LegacySchool
    @new_table_class = School
    super
  end

  def parse
    @rows = Array.new
    @legacy_rows.each do |reg|
      hash = Hash.new
      hash[:id] = reg[:CodigoDoCurso].to_i
      hash[:name] = reg[:NomeDoCurso]
      hash[:acronym] = reg[:SiglaDoCurso]
      hash[:school_area_id] = reg[:CodigoDaArea].to_i
      @rows << hash
    end
    @legacy_rows = nil
  end

end
