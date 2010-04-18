class ImportClass

  def initialize
    @step = 50
    @offset = 0
  end

  def parse
    raise "shouldn't called into this class"
  end

  def fetch
    @legacy_rows = @old_table_class.all(:limit => @step, :offset => @offset)
    @offset += @legacy_rows.size if @legacy_rows
  end

  def put
    @rows.each do |row|
      sa = @new_table_class.new(row)
      sa.save
    end
    @rows = nil
  end

  def execute!
    rows_count = @old_table_class.count
    while rows_count > @offset
      fetch
      parse
      put
    end
  end

end
