class ImportImplementations < ImportClass

  def initialize
    @old_table_class = LegacyImplementations
    @new_table_class = Implementations
    super
  end

  def parse
    @rows = Array.new
    @legacy_rows.each do |reg|
      
      hash = Hash.new
      @rows << hash
    end
    @legacy_rows = nil
  end

end
