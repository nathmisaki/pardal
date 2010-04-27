class LegacyDiscipline < Academnew
  set_table_name "disciplinas"
  set_primary_key "CodigoDaDisciplina"

  belongs_to :legacy_department, :foreign_key => 'CodigoDoDepartamento'

end
