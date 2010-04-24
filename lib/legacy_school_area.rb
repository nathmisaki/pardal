class LegacySchoolArea < Academnew
  set_table_name 'areas'
  set_primary_key 'CodigoDaArea'

  has_many :schools
end
