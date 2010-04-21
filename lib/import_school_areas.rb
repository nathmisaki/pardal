class ImportSchoolAreas < ImportClass

  def initialize
    @old_table_class = LegacySchoolArea
    @new_table_class = SchoolArea
    super
  end

  def parse
    @rows = Array.new
    @legacy_rows.each do |reg|
      hash = Hash.new
      hash[:id] = reg[:CodigoDaArea]
      hash[:name] = reg[:AreaPorExtenso]
      @rows << hash
    end
    @legacy_rows = nil
  end

end
