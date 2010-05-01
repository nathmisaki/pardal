class RemoveFieldsFromCourse < ActiveRecord::Migration
  def self.up
    change_table :courses do |t|
      t.remove :semester
      t.remove :start_dt
      t.remove :end_dt
    end
  end

  def self.down
    change_table :courses do |t|
      t.integer :semester
      t.datetime :start_dt
      t.datetime :end_dt
    end
  end
end
