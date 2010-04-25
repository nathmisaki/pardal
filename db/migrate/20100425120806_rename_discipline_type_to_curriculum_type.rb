class RenameDisciplineTypeToCurriculumType < ActiveRecord::Migration
  def self.up
    rename_table :discipline_types, :curriculum_type
  end

  def self.down
    rename_table :curriculum_types, :discipline_type
  end
end
