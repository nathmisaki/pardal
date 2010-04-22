class ImportDisciplines < ImportClass

  def initialize
    @old_table_class = LegacyDiscipline
    @new_table_class = Discipline
    super
  end

  def parse
    @rows  = Array.new
    @legacy_rows.each do |reg|
      hash = Hash.new
      hash[:id] = reg[:CodigoDaDisciplina].to_i
      hash[:code] = reg[:CodigoDaDisciplina].to_i
      hash[:name] = reg[:NomeDaDisciplina]
      hash[:department_id] = reg[:CodigoDoDepartamento].to_i
      hash[:acronym] = reg[:SiglaDaDisciplina]
      hash[:credit_hours] = reg[:CargaHorariaTeorica]
      @rows << hash
    end
    @legacy_rows = nil
  end

end
