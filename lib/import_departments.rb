class ImportDepartments < ImportClass

  def initialize
    @old_table_class = LegacyDepartment
    @new_table_class = Department
    super
  end

  def parse
    @rows = Array.new
    @legacy_rows.each do |reg|
      hash = Hash.new
      hash[:id] = reg[:CodigoDoDepartamento].to_i
      hash[:name] = reg[:DepartamentoPorExtenso]
      @rows << hash
    end
    @legacy_rows = nil
  end

end
