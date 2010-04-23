class ImportClass
  LOGGER_FILE = RAILS_ROOT + '/log/import.log'
  class ImportLogger < Logger; end

  def initialize
    @step = 500
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
      sa.id = row[:id] if row[:id]
      begin
        sa.save
      rescue Exception => e
        logger.error("#{e.class}: #{e} -- on #{sa.inspect}")
      end
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

  protected

  def logger
    @logger ||= ImportLogger.new(File.open(LOGGER_FILE, 'a'))
  end

end
