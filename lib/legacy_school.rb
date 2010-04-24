class LegacySchool < Academnew
  set_table_name 'cursos'
  set_primary_key 'CodigoDoCurso'

  belongs_to :legacy_school_area, :foreign_key => 'CodigoDaArea'
end
