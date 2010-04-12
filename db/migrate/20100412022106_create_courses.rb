class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.belongs_to :discipline
      t.belongs_to :course_school
      t.integer :grade_list_qty
      t.boolean :grade_list_emissioner
      t.boolean :divide_class

      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
