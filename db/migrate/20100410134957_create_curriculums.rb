class CreateCurriculums < ActiveRecord::Migration
  def self.up
    create_table :curriculums do |t|
      t.belongs_to :school
      t.belongs_to :period
      t.integer :curriculum_type
      t.integer :implementation_semester

      t.timestamps
    end
  end

  def self.down
    drop_table :curriculums
  end
end
