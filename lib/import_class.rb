class ImportClass

  def parse
    raise "shouldn't called into this class"
  end

  def fetch
    @legacy_rows = @old_table_class.all(:limit => @step, :offset => @offset)
    @offset += @legacy_rows.size
  end

  def put
    @rows.each do |row|
      sa = @new_table_class.new(row)
      sa.save
    end
    @rows = nil
  end

  def execute!
    @step = 50
    @offset = 0
    rows_count = @old_table_class.count
    while rows_count > @offset
      fetch
      parse
      put
    end
  end

end
