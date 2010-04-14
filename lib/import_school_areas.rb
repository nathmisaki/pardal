class ImportSchoolAreas

  def parse
    @rows = Array.new
    @legacy_rows.each do |reg|
      hash = Hash.new
      hash[:id] = reg[:CodigoDaArea]
      hash[:name] = reg[:AreaPorExtenso]
      @rows << hash
      p hash
    end
    @legacy_rows = nil
  end

  def fetch
    @legacy_rows = LegacyArea.all(:limit => @step, :offset => @offset)
    @offset += @legacy_rows.size
  end

  def put
    @rows.each do |row|
      sa = SchoolArea.new(row)
      sa.save
    end
    @rows = nil
  end

  def execute!
    @step = 50
    @offset = 0
    rows_count = LegacyArea.count
    while rows_count > @offset
      fetch
      parse
      put
    end
  end

end
