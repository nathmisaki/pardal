class LegacySchool < Academnew
  set_table_name 'cursos'

  belongs_to :legacy_school_area, :foreign_key => 'CodigoDaArea'
end
