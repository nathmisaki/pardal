class CreateCourseSchedules < ActiveRecord::Migration
  def self.up
    create_table :course_schedules do |t|
      t.belongs_to :course_semester
      t.integer :weekday
      t.time :start_hour
      t.time :end_hour

      t.timestamps
    end
  end

  def self.down
    drop_table :course_schedules
  end
end
