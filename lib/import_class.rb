class ImportClass
  LOGGER_FILE = RAILS_ROOT + '/log/import.log'
  class ImportLogger < Logger; end

  def initialize
    @step = ENV['RAILS_IMPORT_STEP'] || 500
    @offset = 0
  end

  def how_long(task)
    i = Time.now.to_f
    yield
    e = Time.now.to_f
    seconds = (e-i)
    puts "  -- #{task} (#{'%.4f' % seconds}) ".ljust(40, "-")
  end

  def parse
    raise "shouldn't called into this class (ImportClass) but in child object"
  end

  def fetch
    @legacy_rows = @old_table_class.all(:limit => @step, :offset => @offset)
    puts "-- fetched #{@legacy_rows.size} rows starting in #{@offset} from #{@old_table_class.table_name}"
    @offset += @legacy_rows.size if @legacy_rows
  end

  def put
    begin
    require 'ar-extensions'
    rescue LoadError
    end
    if ENV['RAILS_IMPORT_BULK_INSERT']
    #if @new_table_class.respond_to?(:import)
      #puts "   -> using #{@new_table_class}.import "
      #@new_table_class.import @rows.first.keys, @rows.map(&:values), :validate => false
      puts "   -> using bulk insert #{@new_table_class} "
      sql_stm = "INSERT INTO #{@new_table_class.table_name} (#{@rows.first.keys.map {|k| k.to_s }.join(",")}) VALUES "
      sql_stm << @rows.map(&:values).map { |value| "(#{value.map{ |v| "'#{v}'" }.join(',')})" }.join(',')
      @new_table_class.connection.execute(sql_stm)
    else
      @rows.each do |row|
        sa = @new_table_class.new(row)
        sa.id = row[:id] if row[:id]
        begin
          sa.save
        rescue Exception => e
          logger.error("#{e.class}: #{e} -- on #{sa.inspect}")
        end
      end
    end
    @rows = nil
  end

  def execute!
    rows_count = @old_table_class.count
    while rows_count > @offset
      how_long(:fetch) { fetch }
      how_long(:parse) { parse }
      how_long(:put) { put }
    end
  end

  protected

  def logger
    @logger ||= ImportLogger.new(File.open(LOGGER_FILE, 'a'))
  end

end
