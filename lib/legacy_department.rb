class LegacyDepartment < Academnew
  set_table_name 'departamentos'
  set_primary_key 'CodigoDoDepartamento'

  has_many :disciplines
end
