class ImportPeriods < ImportClass
  
  def initialize
    @old_table_class = LegacyPeriod
    @new_table_class = Period
    super
  end

  def parse
    @rows = Array.new
    @legacy_rows.each do |reg|
      hash = Hash.new
      hash[:id] = reg[:CodigoDoTurno].to_i
      hash[:name] = reg[:TurnoPorExtenso]
      @rows << hash
    end
    @legacy_rows = nil
  end

end
