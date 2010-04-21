class AddCurriculumFields < ActiveRecord::Migration
  def self.up
    change_table :curriculums do |t|
      t.integer :credit_hours
      t.integer :avg_school_time
      t.integer :max_school_time
    end
  end

  def self.down
    change_table :curriculums do |t|
      t.remove :credit_hours
      t.remove :avg_school_time
      t.remove :max_school_time
    end
  end
end
