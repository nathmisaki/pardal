class ImportImplementations < ImportClass

  def initialize
    @old_table_class = LegacyImplementation
    @new_table_class = Implementation
    super
  end

  def parse
    @rows = Array.new
    @legacy_rows.each do |reg|
      hash = Hash.new
      hash[:discipline_id] = reg[:CodigoDaDisciplina].to_i
      hash[:school_semester] = reg[:Periodo].to_i
      hash[:discipline_type_id] = reg[:TipoDeDisciplina].to_i
      hash[:curriculum_id] = Curriculum.all( :conditions =>
                                            [ "school_id = ?
                                              and period_id = ?
                                              and structure_code = ?",
                                              reg[:CodigoDoCurso].to_i,
                                              reg[:CodigoDoTurno].to_i,
                                              reg[:CodigoDaEstruturaCurricular].to_i]).first
      hash[:curriculum_id] = hash[:curriculum_id].id unless hash[:curriculum_id].nil?
      @rows << hash
    end
    @legacy_rows = nil
  end

end
