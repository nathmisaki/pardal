class ImportEnrollmentSituations < ImportClass

  def initialize
    @old_table_class = LegacyEnrollmentSituation
    @new_table_class = EnrollmentSituation
    super
  end

  def parse
    @rows = Array.new
    @legacy_rows.each do |reg|
      hash = Hash.new
      hash[:id] = reg[:SituacaoDaMatricula].to_i
      hash[:description] = reg[:SituacaoDaMatriculaPorExtenso]
      condition = reg[:CondicaoDaMatricula].to_i
      if condition > 1
      hash[:active] = 0
      else
      hash[:active] = 1
      end
      @rows << hash
    end
    @legacy_rows = nil
  end
end
