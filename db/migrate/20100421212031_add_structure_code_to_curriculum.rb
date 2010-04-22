class AddStructureCodeToCurriculum < ActiveRecord::Migration
  def self.up
    change_table :curriculums do |t|
      t.integer :structure_code
    end
  end

  def self.down
    change_table :curriculums do |t|
      t.remove :structure_code
    end
  end
end
