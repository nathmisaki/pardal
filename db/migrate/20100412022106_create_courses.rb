class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.belongs_to :discipline
      t.belongs_to :course_school
      t.integer :grade_list_qty
      t.boolean :has_grade_list
      t.boolean :divide_class
      t.integer :semester
      t.datetime :start_dt
      t.datetime :end_dt

      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
